import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/post_provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PostProvider>().getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PostProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: Builder(
        builder: (context) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage.isNotEmpty) {
            return Center(child: Text(provider.errorMessage));
          }
          return ListView.builder(
            itemCount: provider.posts.length,
            itemBuilder: (context, index) {
              final post = provider.posts[index];
              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  leading: CircleAvatar(
                    child: Text(post.id.toString()),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
