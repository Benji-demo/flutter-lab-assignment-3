import 'package:albums/features/album/data/datasources/photo_remote_data_source.dart';
import 'package:albums/features/album/data/repo/photo_repository_impl.dart';
import 'package:albums/features/album/domain/entities/photo.dart';
import 'package:albums/features/album/domain/usecases/get_photos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AlbumDetailPage extends StatefulWidget {
  final int albumId;
  final String albumTitle;

  const AlbumDetailPage({super.key, required this.albumId, required this.albumTitle});

  @override
  State<AlbumDetailPage> createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  late Future<List<Photo>> _photos;

  @override
  void initState() {
    super.initState();
    final remote = PhotoRemoteDataSource(client: http.Client());
    final repo = PhotoRepositoryImpl(remoteDataSource: remote);
    final getPhotos = GetPhotos(repository: repo);
    _photos = getPhotos(widget.albumId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.albumTitle)),
      body: FutureBuilder<List<Photo>>(
        future: _photos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));

          final photos = snapshot.data!;
          return ListView.builder(
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return ListTile(
                leading: Image.network(photo.thumbnailUrl),
                title: Text(photo.title),
              );
            },
          );
        },
      ),
    );
  }
}
