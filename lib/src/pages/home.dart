import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/src/data/object/post.dart';
import 'package:riverpod_project/src/data/repositories/item.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _HomePageState();
}
final postsProvider = FutureProvider<List<Post>>((ref) async {
  // Use the fetchPosts function to fetch posts
  return await PostRepository().fetchPosts();
});
class _HomePageState extends State<MyHomePage> {

   @override
  void initState() {
    super.initState();
    PostRepository().fetchPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text("Riverpod"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          AsyncValue<List<Post>> postsAsyncValue = ref.watch(postsProvider);
          return postsAsyncValue.when(
            data: (posts) {
              // Build your UI using the list of posts
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey,
                    elevation: 5,
                    child: ListTile(
                      title: Text(" Title :${posts[index].title!}",style: const TextStyle(
                        fontSize: 20,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold
                      )),
                      subtitle:  Text(" Body : ${posts[index].body!}",style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )),
                      // Customize the ListTile based on your Post class properties
                    ),
                  );
                },
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (error, stackTrace) => Text('Error fetching posts'),
          );
        }
      ),
    );
  }

}


