import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:todo_django/screens/editscreen.dart';
import 'package:todo_django/screens/formscreen.dart';

import '../models/models.dart';
import '../repository/api_function.dart';

final apicontroller=Get.put(Api());
   late Future<List<Todo>> employees;
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: Center(
      child: FutureBuilder<List<Todo>>(
        future : employees,
        builder: (BuildContext context, AsyncSnapshot snapshot){
         if(snapshot.hasError){
          return CircularProgressIndicator();
         }
         if(snapshot.hasData){
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 1/0.8,
               ),
               itemCount: snapshot.data.length,
           itemBuilder: (context,index){
                     var data =snapshot.data[index];
                     final id =data.id;
                     return GestureDetector(
                      onTap: 
                      ()=>Get.to(
                        const EditScreen()
                       ),
                      child:
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(
                            color: Colors.greenAccent,
                          )

                        ),
                       child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    child: Text(
                                  data.title,
                                  maxLines: 1,
                                )),
                                IconButton(
                                    onPressed: () =>
                                        apicontroller.deleteNote(id),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.greenAccent, 
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Flexible(
                                child: Text(
                              data.description,
                              overflow: TextOverflow.fade,
                            )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const SizedBox.expand(
                child: Center(child: Text('Empty Notes')),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(const FormScreen()),
          child: const Icon(Icons.add)),
    );
  }
}