class Audio {
  final int id;
  final String title;
  final String artist;
  final String url;
  final String image;

  Audio({required this.id, required this.title, required this.artist, required this.url, required this.image});

  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
      id: json['id'] as int,
      title: json['title'] as String,
      artist: json['artist'] as String,
      url: json['url'] as String,
      image: json['image'] as String,
    );
  }
}
