import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album_model.dart';

class AlbumRemoteDataSource {
  final http.Client client;

  AlbumRemoteDataSource({required this.client});

  Future<List<AlbumModel>> fetchAlbums() async {
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => AlbumModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }
}
