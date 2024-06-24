class PostModel {
  String? image;
  String? title;
  String? subTitle;
  int? likes;
  int? disLikes;

  PostModel({
    this.image,
    this.title,
    this.subTitle,
    this.likes,
    this.disLikes,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    subTitle = json['subTitle'];
    likes = json['likes'];
    disLikes = json['disLikes'];
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'subTitle': subTitle,
      'likes': likes,
      'disLikes': disLikes,
    };
  }
}
