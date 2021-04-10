List<PostModel> listPostModelFromJson(data) {
  List<PostModel> employees = [];
  if (data != null)
    employees = List<PostModel>.from(
      data.map((item) => PostModel.fromJson(item)),
    ).toList();
  return employees;
}

class PostModel {
  PostModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
