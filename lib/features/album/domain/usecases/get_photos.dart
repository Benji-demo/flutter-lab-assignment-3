import '../entities/photo.dart';
import '../repositories/photo_repository.dart';

class GetPhotos {
  final PhotoRepository repository;

  GetPhotos({required this.repository});

  Future<List<Photo>> call(int albumId) {
    return repository.getPhotos(albumId);
  }
}
