import 'package:albums/features/album/domain/entities/album.dart';
import '../repositories/album_repository.dart';

class GetAlbums {
  final AlbumRepository repository;

  GetAlbums({required this.repository});

  Future<List<Album>> call() {
    return repository.getAlbums();
  }
}
