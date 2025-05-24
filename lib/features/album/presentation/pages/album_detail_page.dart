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
      appBar: AppBar(title: Text("Photos",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      iconTheme: IconThemeData(color: Colors.white),),
      body: FutureBuilder<List<Photo>>(
        future: _photos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));

          final photos = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // columns
                crossAxisSpacing:6,
                mainAxisSpacing: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                final photo = photos[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(photo.url,
                          fit: BoxFit.cover,
                        ),

                        // Gradient 
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                // ignore: deprecated_member_use
                                Colors.black.withOpacity(0.5),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),

                        // Photo title at bottom
                        Positioned(left: 12, right: 12, bottom: 12,
                          child: Text(
                            photo.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
