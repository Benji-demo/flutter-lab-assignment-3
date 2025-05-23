import 'package:albums/features/album/domain/entities/album.dart';

class AlbumModel extends Album {
  AlbumModel({
    required super.id,
    required super.userId,
    required super.title,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
    );
  }
}
