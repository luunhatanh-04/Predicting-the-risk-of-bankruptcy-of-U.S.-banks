# Predicting-the-risk-of-bankruptcy-of-U.S.-banks
 Phân tích và Dự đoán Phá sản Ngân hàng (FDIC Bank Bankruptcy Prediction)
Dự án này ứng dụng Khoa học Dữ liệu (Data Science) và các mô hình Học máy (Machine Learning) để dự đoán nguy cơ phá sản của các ngân hàng dựa trên dữ liệu tài chính từ tổ chức FDIC. Mục tiêu trọng tâm là xây dựng một hệ thống đánh giá rủi ro mạnh mẽ, kết hợp giữa kỹ thuật Ensemble Learning và khả năng giải thích mô hình (Model Explainability).

 Quy trình Thực hiện và Cơ sở Lý thuyết
Dự án được chia thành các giai đoạn chính, bao gồm từ việc xử lý dữ liệu thô cho đến khi xuất ra hệ thống cảnh báo rủi ro hoàn chỉnh.

1. Khai phá và Tiền xử lý dữ liệu (EDA & Data Preprocessing)
Làm sạch dữ liệu: Xử lý các giá trị thiếu (missing values) và loại bỏ nhiễu từ tập dữ liệu thô của FDIC.

Feature Engineering: Khai phá và tạo ra các đặc trưng tài chính mới có ý nghĩa thống kê cao, giúp mô hình dễ dàng nhận diện các dấu hiệu suy yếu tài chính của ngân hàng.

Phân tích hành vi (RFM Analysis): Áp dụng mô hình RFM (Recency, Frequency, Monetary) để phân loại và đánh giá đặc tính nhóm đối tượng, đóng vai trò như một góc nhìn mở rộng trong việc đánh giá mức độ hoạt động. (File tương ứng: rfm_cleaned.csv).

2. Xây dựng và Huấn luyện Mô hình (Machine Learning Modeling)
Cân bằng dữ liệu: Áp dụng các kỹ thuật xử lý để giải quyết bài toán mất cân bằng lớp (thường gặp trong các bộ dữ liệu dự đoán phá sản, do số lượng ngân hàng phá sản thực tế chiếm tỷ lệ nhỏ).

Ensemble Learning: Thay vì sử dụng một thuật toán đơn lẻ, dự án xây dựng một hệ thống Pipeline kết hợp sức mạnh của Random Forest và XGBoost. Phương pháp này giúp giảm thiểu phương sai (variance), tránh hiện tượng quá khớp (overfitting) và tăng cường độ chính xác tổng thể.

(File tương ứng: training_fdicbanks.ipynb, training_fdicbanks.csv).

3. Giải thích Mô hình (Model Explainability)
Trong lĩnh vực tài chính, việc giải thích "tại sao" mô hình đưa ra quyết định là yếu tố bắt buộc. Dự án tích hợp phương pháp SHAP (SHapley Additive exPlanations) dựa trên lý thuyết trò chơi hợp tác.

Hệ thống SHAP giúp bóc tách và định lượng mức độ đóng góp của từng biến số tài chính (ví dụ: tỷ lệ vốn, lợi nhuận ròng, tỷ lệ nợ xấu) vào điểm số rủi ro cuối cùng của một ngân hàng cụ thể.

(File tương ứng: ensemble_rf_xgb_shap_v1.pkl).

4. Đánh giá và Phân loại Rủi ro (Output & Risk Scoring)
Đầu ra của hệ thống không chỉ là nhị phân (Phá sản / Không phá sản) mà được thiết kế dưới dạng Xác suất (Probability) và Điểm rủi ro (Risk Score).

Dựa trên các ngưỡng xác suất được tối ưu, các ngân hàng được phân loại thành các nhóm nguy cơ khác nhau (Ví dụ: Nguy cơ Cao/Thấp), cung cấp một công cụ cảnh báo sớm (Early Warning System) trực quan và có giá trị thực tiễn cao.

(File tương ứng: bankruptcy_predictions_clean.csv).
