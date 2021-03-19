class Reviews {
  String author;
  String content;
  String createdAt;
  String id;
  String updatedAt;
  String url;

  Reviews(
      {this.author,
      this.content,
      this.createdAt,
      this.id,
      this.updatedAt,
      this.url});

  Reviews.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    return data;
  }
}
