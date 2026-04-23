-- =========================================================================
-- DỰ ÁN: RETAIL BANKING ANALYTICS & FRAUD DETECTION 
-- =========================================================================

-- -------------------------------------------------------------------------
-- PHẦN 1: KHỞI TẠO CƠ SỞ DỮ LIỆU & DỮ LIỆU MẪU 
-- -------------------------------------------------------------------------

-- Xóa bảng cũ nếu đã tồn tại để tránh lỗi khi chạy lại code
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Accounts;
DROP TABLE IF EXISTS Customers;

-- 1. Tạo bảng Customers
CREATE TABLE Customers (
    client_id INT PRIMARY KEY, 
    age INT, 
    job VARCHAR(50), 
    credit_score INT, 
    join_date DATE
);

-- 2. Tạo bảng Accounts
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY, 
    client_id INT, 
    account_type VARCHAR(50), 
    balance DECIMAL(15,2)
);

-- 3. Tạo bảng Transactions
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY, 
    account_id INT, 
    transaction_date DATE, 
    amount DECIMAL(15,2), 
    transaction_type VARCHAR(20)
);

-- Insert dữ liệu mẫu
INSERT INTO Customers VALUES 
(1, 25, 'Engineer', 600, '2023-01-15'), 
(2, 45, 'Doctor', 750, '2020-05-20'),
(3, 30, 'Artist', 500, '2022-11-10'), 
(4, 50, 'Manager', 800, '2019-03-01');

INSERT INTO Accounts VALUES 
(101, 1, 'Savings', 50000), 
(102, 1, 'Checking', 15000),
(103, 2, 'Savings', 200000), 
(104, 3, 'Checking', 100000), 
(105, 4, 'Savings', 300000);

INSERT INTO Transactions VALUES 
(1001, 101, '2024-03-01', 500, 'Deposit'), 
(1002, 101, '2024-03-15', 20000, 'Withdrawal'), -- Giao dịch bất thường (Bị bắt ở Yêu cầu 3)
(1003, 103, '2024-02-10', 1000, 'Deposit'), 
(1004, 104, '2023-10-01', 5000, 'Deposit'); -- Khách hàng ngủ đông (Bị bắt ở Yêu cầu 4)

-- -------------------------------------------------------------------------
-- PHẦN 2: CHẠY CÁC TRUY VẤN PHÂN TÍCH
-- -------------------------------------------------------------------------

-- YÊU CẦU 1: Rủi ro thanh khoản (Top 5 khách nhiều tiền nhưng điểm tín dụng thấp)
PRINT '--- KET QUA YEU CAU 1: RUI RO THANH KHOAN ---';
WITH AvgCredit AS (
    SELECT AVG(credit_score) AS avg_score FROM Customers
)
SELECT TOP 5 
    c.client_id, 
    c.credit_score, 
    SUM(a.balance) AS total_balance
FROM Customers c
JOIN Accounts a ON c.client_id = a.client_id
WHERE c.credit_score < (SELECT avg_score FROM AvgCredit)
GROUP BY c.client_id, c.credit_score
ORDER BY total_balance DESC;


-- YÊU CẦU 2: Phân nhóm khách hàng (Segmentation dựa trên tổng giao dịch 6 tháng qua)
PRINT '--- KET QUA YEU CAU 2: PHAN NHOM KHACH HANG ---';
SELECT 
    c.client_id,
    ISNULL(SUM(t.amount), 0) AS total_volume_6m,
    CASE 
        WHEN ISNULL(SUM(t.amount), 0) >= 50000 THEN 'High Value'
        WHEN ISNULL(SUM(t.amount), 0) BETWEEN 10000 AND 49999 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM Customers c
JOIN Accounts a ON c.client_id = a.client_id
LEFT JOIN Transactions t ON a.account_id = t.account_id 
    AND t.transaction_date >= DATEADD(month, -6, GETDATE())
GROUP BY c.client_id;


-- YÊU CẦU 3: Phát hiện giao dịch bất thường (Lớn hơn 3 lần trung bình các GD trước đó)
PRINT '--- KET QUA YEU CAU 3: GIAO DICH BAT THUONG ---';
WITH RollingAvg AS (
    SELECT 
        transaction_id,
        account_id,
        transaction_date,
        amount,
        AVG(amount) OVER(
            PARTITION BY account_id 
            ORDER BY transaction_date 
            ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
        ) AS avg_past_transactions
    FROM Transactions
)
SELECT * FROM RollingAvg
WHERE amount > 3 * avg_past_transactions;


-- YÊU CẦU 4: Phân tích Tỷ lệ Rời bỏ (Không có giao dịch nào trong 90 ngày)
PRINT '--- KET QUA YEU CAU 4: TY LE ROI BO THEO DO TUOI ---';
WITH LastActivity AS (
    SELECT 
        c.client_id, 
        c.age, 
        MAX(t.transaction_date) AS last_txn_date
    FROM Customers c
    LEFT JOIN Accounts a ON c.client_id = a.client_id
    LEFT JOIN Transactions t ON a.account_id = t.account_id
    GROUP BY c.client_id, c.age
),
ChurnStatus AS (
    SELECT 
        age,
        CASE 
            WHEN last_txn_date IS NULL OR last_txn_date < DATEADD(day, -90, GETDATE()) THEN 1
            ELSE 0 
        END AS is_churned
    FROM LastActivity
)
SELECT 
    age,
    COUNT(*) AS total_customers,
    SUM(is_churned) AS churned_customers,
    ROUND(SUM(is_churned * 1.0) * 100 / COUNT(*), 2) AS churn_rate_percentage
FROM ChurnStatus
GROUP BY age
ORDER BY churn_rate_percentage DESC;