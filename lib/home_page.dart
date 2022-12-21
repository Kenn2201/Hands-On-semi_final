import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'todo_info.dart';
import 'todo_model.dart';
import 'updated_todo.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<ToDoItem> todos = [];

  @override
  void initState() {
    super.initState();
    getToDos();
  }

  getToDos()async{
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await http.get(url);
    print(response.statusCode);
    List<dynamic>data = convert.jsonDecode(response.body);
    setState(() {
      todos = data.map((todo1) => ToDoItem.fromMap(todo1)).toList();
    });

  }
  UpdatedTodos(ToDoItem todo2)async{
    var response = await http.put(Uri.parse('https://jsonplaceholder.typicode.com/todos/${todo2.id}?title=${todo2.title}&completed=${todo2.completed}'));
    if (response.statusCode == 200){
      _showSnackBar(context,'"${todo2.title}" Updated Successfully');
      print(response.statusCode);
    }
  }

  void _showSnackBar(BuildContext context, String message,){
    final snackbar = SnackBar(content: Text(message),backgroundColor: Colors.green,);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ToDo'),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          padding: const EdgeInsets.all(5),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todoItem = todos[index];
              return  Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2, color: Colors.yellow),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Text(todoItem.title),
                  trailing: ElevatedButton(
                    onPressed: ()async{
                      var updatedTodo1 = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UpdatedTodo(updatedToDo: todoItem,))
                      );
                      UpdatedTodos(updatedTodo1);
                      setState(() {
                        todos[index] = updatedTodo1;

                      });
                    },
                    child: const Text('Update'),

                  ),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ToDoInfo(todo:todoItem,))
                    );
                  },
                ),

              );
            }
        ),
      ),
    );
  }
}
