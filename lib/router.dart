import 'package:go_router/go_router.dart';
import '../features/album/presentation/pages/album_list_page.dart';
import '../features/album/presentation/pages/album_detail_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AlbumListPage(),
    ),
    GoRoute(
      path: '/album/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final title = state.extra as String;
        return AlbumDetailPage(albumId: id, albumTitle: title);
      },
    ),
  ],
);
