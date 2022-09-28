import 'package:calculator/util/dialog_box.dart';
import 'package:calculator/util/todo_title.dart';
import "package:flutter/material.dart";
import '../util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //text controller
  final _controller=TextEditingController();
   //list of todo tasks
   List toDoList=[
    ["Make tutorial",false],
    ["100 Push-UP",true],
   ];
   //checkbox was tapped
   void checkBoxChanged(bool? value,int index){
    setState(() {
      toDoList[index][1]=!toDoList[index][1];
    });
   }
   //save new task
   void saveNewTask(){
    setState(() {
      toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
   }
   //create new task
   void createNewTask(){
    showDialog(context: context, 
    builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: ()=>Navigator.of(context).pop(),
      );
      },
      );
   }
   //delete Task
   void deleteTask(int index){
    setState(() {
      toDoList.removeAt(index);
    });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      appBar: AppBar(
        title: Text("TO DO",textAlign: TextAlign.center,),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body:ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context,index){
          return ToDoTitle(
            taskName: toDoList[index][0], 
            taskCompleted: toDoList[index][1], 
            onChanged: (value)=>checkBoxChanged(value,index),
            deleteFunction: (context)=>deleteTask,
            ); 
        },
      )
    );
  }
}