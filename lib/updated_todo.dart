import 'package:flutter/material.dart';

import 'todo_model.dart';



class UpdatedTodo extends StatefulWidget {
  final ToDoItem updatedToDo;

  const UpdatedTodo({Key? key,required this.updatedToDo}) : super(key: key);

  @override
  State<UpdatedTodo> createState() => _UpdatedTodoState();
}

class _UpdatedTodoState extends State<UpdatedTodo> {

  var formKey = GlobalKey<FormState>();
  late final titleText =  TextEditingController(text: widget.updatedToDo.title);
  late bool completedtext = widget.updatedToDo.completed;


  @override
  void dispose(){
    titleText.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update ToDo'),
        elevation: 0,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: titleText,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Title',
                labelText: 'Ex: Harry Potter',
              ),
              validator: (idnum){
                return (idnum == '') ? 'Please enter Title' : null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Completed'),
                Switch(
                    value: completedtext,
                    onChanged: (bool value) {
                      setState(() {
                        completedtext = value;
                      });
                    },
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 20,
              child: ElevatedButton(
                onPressed: () async{
                  var validform = formKey.currentState!.validate();
                  formKey.currentState!.save();
                  if (validform) {
                    print('The Text Inputted are valid!');
                    ToDoItem newTodoitem = ToDoItem(
                      userId: widget.updatedToDo.userId,
                      id: widget.updatedToDo.id,
                      title: titleText.text,
                      completed: completedtext,
                    );

                    Navigator.pop(context,newTodoitem);
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

