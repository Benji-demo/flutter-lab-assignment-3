import 'package:albums/features/album/domain/entities/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbums();
}