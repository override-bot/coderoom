class Comment{
  final int id;
  final String displayName;
  final String contribution;
  final int contributionTime;

  Comment({this.id, this.displayName, this.contribution, this.contributionTime});

  factory Comment.fromJson(Map<String, dynamic> json){
    return Comment(
      id: json['id'],
      displayName: json['displayName'],
      contribution: json['contribution'],
      contributionTime: json['contributionTime']     
    );
  }
}