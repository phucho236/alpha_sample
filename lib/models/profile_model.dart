class ProfileModel {
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String id;

  ProfileModel({
    this.name = "Phuc Ho",
    this.firstName = "Ho",
    this.lastName = "Phuc",
    this.email = "phucho@gmail.com",
    this.id = "119",
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "id": id,
      };

  static final empty =
      ProfileModel(email: '', id: '', name: "", firstName: "", lastName: "");
}
