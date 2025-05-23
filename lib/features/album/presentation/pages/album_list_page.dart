import 'package:albums/features/album/data/datasources/album_remote_data_source.dart';
import 'package:albums/features/album/data/repo/album_repository_impl.dart';
import 'package:albums/features/album/domain/entities/album.dart';
import 'package:albums/features/album/domain/usecases/get_albums.dart';
import 'package:albums/features/album/presentation/pages/album_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlbumListPage extends StatefulWidget {
  const AlbumListPage({super.key});

  @override
  State<AlbumListPage> createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  late Future<List<Album>> _albums;

  @override
  void initState() {
    super.initState();
    final remoteDataSource = AlbumRemoteDataSource(client: http.Client());
    final repository = AlbumRepositoryImpl(remoteDataSource: remoteDataSource);
    final getAlbums = GetAlbums(repository: repository);
    _albums = getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Albums")),
      body: FutureBuilder<List<Album>>(
        future: _albums,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));

          final albums = snapshot.data!;
          return ListView.builder(
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];
              return ListTile(
                title: Text(album.title),
                subtitle: Text('Album ID: ${album.id}'),
                onTap: () {
                  // Integrate to details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) => AlbumDetailPage(
                        albumId: album.id,
                        albumTitle: album.title,
                      ),
                  ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
