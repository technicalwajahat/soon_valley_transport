class UserModel {
  String? uid;
  String? fullName;
  String? email;
  String? mobileNo;
  String? role;

  UserModel({this.uid, this.fullName, this.email, this.mobileNo, this.role});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
      mobileNo: map['mobileNo'],
      role: map['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'mobileNo': mobileNo,
      'role': role,
    };
  }
}
