import 'package:albums/features/album/domain/entities/album.dart';
import '../../domain/repositories/album_repository.dart';
import '../datasources/album_remote_data_source.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteDataSource remoteDataSource;

  AlbumRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Album>> getAlbums() {
    return remoteDataSource.fetchAlbums();
  }
}
