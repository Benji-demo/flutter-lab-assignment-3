// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:albums/features/album/data/repo/album_repository_impl.dart';
import 'package:albums/features/album/domain/usecases/get_albums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:albums/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // ignore: prefer_typing_uninitialized_variables
    var albumRemote;
    final albumRepo = AlbumRepositoryImpl(remoteDataSource: albumRemote);
    final getAlbums = GetAlbums(repository: albumRepo);
  
    await tester.pumpWidget(MyApp(getAlbums: getAlbums,));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
