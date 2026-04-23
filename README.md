# Predicting-the-risk-of-bankruptcy-of-U.S.-banks
Dự án này ứng dụng Khoa học Dữ liệu (Data Science) và các mô hình Học máy (Machine Learning) để dự đoán nguy cơ phá sản của các ngân hàng dựa trên dữ liệu tài chính từ FDIC. Mục tiêu là xây dựng một hệ thống cảnh báo sớm, kết hợp giữa sức mạnh dự đoán của các mô hình Ensemble và khả năng giải thích mô hình (Model Explainability).

Dự án bao gồm các tệp dữ liệu, mã nguồn phân tích và mô hình đã được huấn luyện:
1. Mã nguồn (Jupyter Notebooks)
fdic_banks.ipynb: Quá trình Khai phá dữ liệu (EDA - Exploratory Data Analysis), xử lý giá trị thiếu, làm sạch dữ liệu và tạo ra các biến mới (Feature Engineering) từ tập dữ liệu thô của FDIC.

training_fdicbanks.ipynb: Quá trình huấn luyện mô hình học máy. Bao gồm các bước chia tập dữ liệu, cân bằng dữ liệu, huấn luyện mô hình Ensemble và đánh giá hiệu suất.

2. Dữ liệu (Datasets)
training_fdicbanks.csv: Dữ liệu tài chính đã qua tiền xử lý, sẵn sàng để đưa vào huấn luyện mô hình.

bankruptcy_predictions_clean.csv: Bảng dữ liệu đầu ra chứa kết quả dự đoán và xác suất rủi ro (Risk Score/Probability) cho từng ngân hàng.

rfm_cleaned.csv: Dữ liệu làm sạch phục vụ cho bài toán phân tích nhóm khách hàng theo mô hình RFM (Recency, Frequency, Monetary) - một phần mở rộng trong phân tích hành vi.

3. Mô hình (Model)
ensemble_rf_xgb_shap_v1.pkl: Tệp mô hình đã được huấn luyện và lưu lại (đóng gói bằng pickle). Đây là một mô hình Pipeline kết hợp giữa Random Forest và XGBoost, đồng thời tích hợp SHAP để giải thích mức độ đóng góp của từng đặc trưng (feature importance) vào kết quả dự đoán.
