import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:todo_django/repository/url.dart';

import '../models/models.dart';

class Api extends GetxController{
Future<List<Todo>>getTodo()async{
final response=await http.get(Uri.parse("${Nve.unlprifix}/todo"));
final items =json.decode(response.body).cast<Map<String,dynamic>>();
List<Todo>employees = items.map<Todo>((json){
  return Todo.fromJson(json);

}).toList();
return employees;
}
Future<void>addTodo(Todo todo)async{
final url = Uri.parse("${Nve.unlprifix}/todos");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(todo.toJson());
    try {

      final response =await http.post(url,headers:headers,body:body);
      if(response.statusCode ==201){
          isSuccess();
      }else{
        print("failed to create note.Status code:${response.statusCode}");
        print('Response body:${response.body}');
      }
    }catch(e){
      print("Error:$e");
    }
}
Future<void>isSuccess()async{
  await  getTodo();
  Get.back();
}
Future<void>updateTodo(Todo todo,String id)async{
  final url = Uri.parse("${Nve.unlprifix}/todos/$id");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(todo.toJson());

    try {
      final response = await http.patch(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Note updated successfully
        print("Note updated successfully");
      } else {
        // Handle error response
        print("Failed to update note. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      // Handle network or other errors
      print("Error: $e");
    }
    getTodo();
    Get.back();
  }
  Future<void> deleteNote(String noteId) async {
    final url = Uri.parse("${Nve.unlprifix}/todos/$noteId");

    try {
      final response = await http.delete(url);

      if (response.statusCode == 204) {
        // Note deleted successfully

        print("Note deleted successfully");
      } else {
        // Handle error response
        print("Failed to delete note. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      // Handle network or other errors
      print("Error: $e");
    }
  }
}