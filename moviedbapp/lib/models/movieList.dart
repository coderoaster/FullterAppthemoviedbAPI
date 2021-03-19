class MovieList {
  int id;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  String title;
  num voteAverage;

  MovieList(
      {this.id,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.voteAverage});

  MovieList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    voteAverage = json['vote_average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    return data;
  }
}
