import 'package:albums/features/album/domain/usecases/get_albums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbums getAlbums;

  AlbumBloc(this.getAlbums) : super(AlbumLoading()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albums = await getAlbums();
        emit(AlbumLoaded(albums));
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });
  }
}
