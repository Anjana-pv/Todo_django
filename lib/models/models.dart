class Todo{
  final String? id;
  final String? title;
  final String? description;

  Todo({this.id,required this.title,required this.description});
factory Todo.fromJson(Map<String,dynamic>json){
  return Todo(
    id:json['id'].toString(),
    title:json['title']??'null found',
    description: json['Description']??"null found",


  );

}

  Map<String, dynamic> toJson() => {
    'id' : id,
    'Title': title,
    'Discription': description, 
  };
}