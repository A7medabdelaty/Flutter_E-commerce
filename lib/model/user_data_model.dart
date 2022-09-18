class UserDataModel {
  bool? status;
  UserData? data;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = UserData.fromJson(json['data']);
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
  }
}
