import '../../domain/entities/photo.dart';

class PhotoModel extends Photo {
  PhotoModel({
    required super.id,
    required super.albumId,
    required super.title,
    required super.url,
    required super.thumbnailUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      albumId: json['albumId'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
