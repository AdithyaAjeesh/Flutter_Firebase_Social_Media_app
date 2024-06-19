class UserModel {
  String? userName;
  String? email;
  String? uid;
  String? password;
  String? image;
  int? followers;
  int? following;

  UserModel({
    this.userName,
    this.email,
    this.uid,
    this.password,
    this.image,
    this.followers,
    this.following,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    uid = json['uid'];
    password = json['password'];
    image = json['image'];
    followers = json['followers'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'uid': uid,
      'password': password,
      'image': image,
      'followers': followers,
      'following': following,
    };
  }
}
