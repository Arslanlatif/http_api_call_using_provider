import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/models/post_mc.dart';
import 'package:provider_example/providers/post_provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('posts'),
      ),
      body: Consumer<PostProvider>(
        builder: (BuildContext context, value, Widget? child) => Center(
          child: (value.isLoading)
              ? const CircularProgressIndicator()
              : RefreshIndicator(
                  backgroundColor: Colors.amberAccent,
                  onRefresh: () {
                    return postProvider.getPosts();
                  },
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: value.postsList.length,
                      itemBuilder: (context, index) {
                        PostMc post = value.postsList[index];

                        return ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.amberAccent,
                              child: Text(post.id.toString())),
                          title: Text(post.title.toString()),
                          subtitle: Text(post.body.toString()),
                          trailing: Card(
                              elevation: 10,
                              shadowColor: Colors.black,
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Center(
                                      child: Text(post.userId.toString())))),
                        );
                      }),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await postProvider.getPosts();
          log(postProvider.postsList.length.toString());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
