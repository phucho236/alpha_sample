class ResponseData<T> {
  dynamic data;
  String status;
  String message;
  int statusCode;

  ResponseData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? json['data'] as T : null;
    status = json['status'] != null ? json['status'] : null;
    message = json['message'] != null ? json['message'] : null;
    statusCode = json['status_code'] != null ? json['status_code'] : null;
  }
}
