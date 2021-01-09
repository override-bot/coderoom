import 'comment.dart';
class Post{
  final int id;
  final String displayName;
  final String imageUrl;
  final String conversation;
  final int postDate;
  final List<Comment>comments;

  Post({this.id, this.displayName, this.imageUrl, this.conversation, this.postDate, this.comments});
  factory Post.fromJson(Map<String, dynamic> json){
      List<Comment>commentsList = [];
      if(json['comments'] != null){
        final commentsMap = json['comments'].cast<Map<String, dynamic>>();
        commentsList = commentsMap.map<Comment>((json){
          return Comment.fromJson(json);
        }).toList();
      }return Post(
        id: json['id'],
        displayName: json['displayName'],
        imageUrl: json['imageUrl'],
        conversation: json['conversation'],
        postDate: json['postDate'],
        comments: commentsList,
      );
  }

}