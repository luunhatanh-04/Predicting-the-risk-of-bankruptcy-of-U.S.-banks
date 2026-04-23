# Predicting-the-risk-of-bankruptcy-of-U.S.-banks
🏦 Dự án Phân tích và Dự đoán Phá sản Ngân hàng (FDIC Bank Bankruptcy Prediction)
Dự án này ứng dụng Khoa học Dữ liệu (Data Science) và các mô hình Học máy (Machine Learning) để dự đoán nguy cơ phá sản của các ngân hàng dựa trên dữ liệu tài chính từ FDIC. Mục tiêu là xây dựng một hệ thống cảnh báo sớm, kết hợp giữa sức mạnh dự đoán của các mô hình Ensemble và khả năng giải thích mô hình (Model Explainability).

🗂️ Cấu trúc dự án
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

🛠️ Công nghệ sử dụng
Ngôn ngữ: Python 3.x

Thư viện xử lý & Phân tích dữ liệu: pandas, numpy

Học máy: scikit-learn (Random Forest, Pipeline), xgboost

Giải thích mô hình: shap

Môi trường chạy: Jupyter Notebook

🚀 Hướng dẫn cài đặt và sử dụng
Bước 1: Cài đặt các thư viện cần thiết
Mở terminal/command prompt và chạy lệnh sau để cài đặt các gói phụ thuộc:

Bash
pip install pandas numpy scikit-learn xgboost shap jupyter
Bước 2: Khai phá và Tiền xử lý dữ liệu

Mở tệp fdic_banks.ipynb bằng Jupyter Notebook để xem chi tiết quá trình làm sạch dữ liệu. Notebook này sẽ xuất ra các tệp .csv dữ liệu sạch.

Bước 3: Huấn luyện hoặc Dự đoán

Mở tệp training_fdicbanks.ipynb để chạy lại quy trình đánh giá mô hình.

Nếu bạn chỉ muốn tích hợp dự đoán vào một ứng dụng khác, bạn có thể tải trực tiếp file ensemble_rf_xgb_shap_v1.pkl và dự đoán trên dữ liệu mới thông qua thư viện joblib hoặc pickle.

Python
import joblib
import pandas as pd

# Load pipeline mô hình
model = joblib.load('ensemble_rf_xgb_shap_v1.pkl')

# Tải dữ liệu cần dự đoán
new_data = pd.read_csv('your_new_bank_data.csv')

# Đưa ra dự đoán
predictions = model.predict(new_data)
📊 Kết quả đầu ra nổi bật
Mô hình không chỉ xuất ra kết quả phân loại (Nguy cơ Cao/Thấp) mà còn cung cấp Risk Score (Điểm rủi ro) và Xác suất (Probability) được tổng hợp chi tiết trong tệp bankruptcy_predictions_clean.csv. Hệ thống SHAP value đi kèm giúp minh bạch hóa việc tại sao một ngân hàng bị đánh giá là có nguy cơ cao (ví dụ: do tỷ lệ vốn thấp, nợ xấu cao,...).
