import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProfileFaceBookModel extends Equatable {
  ProfileFaceBookModel({
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.id,
  });

  String name;
  String firstName;
  String lastName;
  String email;
  String id;

  factory ProfileFaceBookModel.fromJson(Map<String, dynamic> json) =>
      ProfileFaceBookModel(
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
  static final empty = ProfileFaceBookModel(
      email: '', id: '', name: "", firstName: "", lastName: "");
  @override
  List<Object> get props => [email, id, name, firstName, lastName];
}
