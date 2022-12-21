class ToDoItem{

  final int id;
  final int userId;
  final String title;
  final bool completed;

  ToDoItem({
    required this.id,
    required this.title,
    required this.userId,
    required this.completed});

  factory ToDoItem.fromMap(Map<String,dynamic>json) => ToDoItem(
      id: json['id'],
      title: json['title'],
      userId: json['userId'],
      completed: json['completed']);

  Map<String,dynamic> toJson(){
    return {
      'id':id,
      'userId': userId,
      'title':title,
      'completed': completed,
    };
  }

}