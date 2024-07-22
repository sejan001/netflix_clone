class MoviesModel {
  int? id;
  String? title;
  int? year;
  List<String>? genre;
  double? rating;
  String? director;
  List<String>? actors;
  String? plot;
  String? poster;
  String? trailer;
  int? runtime;
  String? awards;
  String? country;
  String? language;
  String? boxOffice;
  String? production;
  String? website;

  MoviesModel({
    this.id,
    this.title,
    this.year,
    this.genre,
    this.rating,
    this.director,
    this.actors,
    this.plot,
    this.poster,
    this.trailer,
    this.runtime,
    this.awards,
    this.country,
    this.language,
    this.boxOffice,
    this.production,
    this.website,
  });

  MoviesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    year = json['year'];
    genre = json['genre'].cast<String>();
    rating = (json['rating'] is int) ? (json['rating'] as int).toDouble() : json['rating'];
    director = json['director'];
    actors = json['actors'].cast<String>();
    plot = json['plot'];
    poster = json['poster'];
    trailer = json['trailer'];
    runtime = json['runtime'];
    awards = json['awards'];
    country = json['country'];
    language = json['language'];
    boxOffice = json['boxOffice'];
    production = json['production'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['year'] = this.year;
    data['genre'] = this.genre;
    data['rating'] = this.rating;
    data['director'] = this.director;
    data['actors'] = this.actors;
    data['plot'] = this.plot;
    data['poster'] = this.poster;
    data['trailer'] = this.trailer;
    data['runtime'] = this.runtime;
    data['awards'] = this.awards;
    data['country'] = this.country;
    data['language'] = this.language;
    data['boxOffice'] = this.boxOffice;
    data['production'] = this.production;
    data['website'] = this.website;
    return data;
  }
}
