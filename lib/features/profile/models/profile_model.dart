class UserProfileModel {
  int? id;
  String? firstName;
  String? lastName;
  int? age;
  String? gender;
  String? email;
  String? birthDate;
  String? image;

  UserProfileModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.age,
        this.gender,
        this.email,
        this.birthDate,
        this.image});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    gender = json['gender'];
    email = json['email'];
    birthDate = json['birthDate'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['birthDate'] = this.birthDate;
    data['image'] = this.image;
    return data;
  }
}
