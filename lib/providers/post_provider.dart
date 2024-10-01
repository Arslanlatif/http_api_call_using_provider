import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider_example/models/post_mc.dart';

class PostProvider extends ChangeNotifier {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const _endPoint = '/posts';
  bool isLoading = false;
  List<PostMc> postsList = [];

  Future<void> getPosts() async {
    try {
      isLoading = true;
      notifyListeners();

      // Clear existing posts before fetching new ones
      postsList.clear();

      Uri uri = Uri.parse(_baseUrl + _endPoint);
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> responseList = jsonDecode(response.body);
        postsList =
            responseList.map((postItem) => PostMc.fromMap(postItem)).toList();
      } else {
        log('Failed to load posts: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Error fetching posts: $e', error: e, stackTrace: stackTrace);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
