import '../../domain/entities/photo.dart';
import '../../domain/repositories/photo_repository.dart';
import '../datasources/photo_remote_data_source.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoRemoteDataSource remoteDataSource;

  PhotoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Photo>> getPhotos(int albumId) {
    return remoteDataSource.fetchPhotos(albumId);
  }
}
