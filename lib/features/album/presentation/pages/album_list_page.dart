import 'package:albums/features/album/presentation/bloc/album_bloc.dart';
import 'package:albums/features/album/presentation/bloc/album_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AlbumListPage extends StatelessWidget {
  const AlbumListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoaded) {
            final albums = state.albums;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return ListTile(
                  title: Text(album.title),
                  onTap: () {
                    context.push('/album/${album.id}', extra: album.title);
                  },
                );
              },
            );
          } else if (state is AlbumError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No albums yet'));
        },
      ),
    );
  }
}
