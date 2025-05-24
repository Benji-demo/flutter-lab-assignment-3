import 'package:albums/features/album/data/repo/album_repository_impl.dart';
import 'package:albums/features/album/domain/usecases/get_albums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'features/album/data/datasources/album_remote_data_source.dart';
import 'features/album/presentation/bloc/album_bloc.dart';
import 'features/album/presentation/bloc/album_event.dart';
import 'router.dart';

void main() {
  final albumRemote = AlbumRemoteDataSource(client: http.Client());
  final albumRepo = AlbumRepositoryImpl(remoteDataSource: albumRemote);
  final getAlbums = GetAlbums(repository: albumRepo);

  runApp(MyApp(getAlbums: getAlbums));
}

class MyApp extends StatelessWidget {
  final GetAlbums getAlbums;

  const MyApp({super.key, required this.getAlbums});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlbumBloc(getAlbums)..add(FetchAlbums()),
      child: MaterialApp.router(
        title: 'Albums',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: const Color(0xFF4B5A78), // Main color
            // secondary: Colors.amber,
            )
            ),
      ),
    );
  }
}
