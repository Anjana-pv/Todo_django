


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todo_django/models/models.dart';
import 'package:todo_django/repository/form_fuction.dart';
import 'package:todo_django/screens/homescreen.dart';

import '../repository/api_function.dart';


final formController = Get.put(FormFunctions());
final apiController = Get.find<Api>();



class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:18.0),
            child: TextButton.icon(
              onPressed: ()=> addtodo(), 
              icon: const Icon(Icons.save,color:Colors.greenAccent),
                
              label: const Text("Save",style: TextStyle(color: Colors.greenAccent),),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        child: ListView(children: [
          TextFormField(
            controller: formController.titleController ,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Tilte',
             hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              
            ),
          ),
          TextFormField(
            maxLength: 35,
            controller: formController.descriptionController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Description",
             
            ),
          )
        ],),
      ),
    );
  }

addtodo(){
  final todoObject=Todo(
    title: formController.titleController.text,
  description:formController.descriptionController.text );
  apicontroller.addTodo(todoObject);
}
}