import 'package:riverpod_project/src/data/helper/api_base_helper.dart';
import 'package:riverpod_project/src/data/object/post.dart';

class PostRepository {
  String endPoint = "posts";
  final ApiBaseHelper _apiBaseHelper =ApiBaseHelper();

  Future<List<Post>> fetchPosts() async {
    List<dynamic> result = await _apiBaseHelper.request(endPoint, "GET", '');

    List<Post> posts = [];

    if (result != null && result.isNotEmpty) {
      for (var item in result) {
        final post = Post.fromJson(item as Map<String, dynamic>);
        posts.add(post);
        print(post);
      }
    }

    return posts;
  }
}
