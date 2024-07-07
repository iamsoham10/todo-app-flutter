import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  final bool isUpdate;
  const HomePage({super.key, required this.isUpdate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void addNewTask() {
    Task newTask = Task(
        id: Uuid().v1(),
        userid: "demo_user",
        content: contentController.text,
        dateadded: DateTime.now());

    Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
    Navigator.pop(context);
  }

  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TaskProvider tasksProvider = Provider.of<TaskProvider>(context);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("To-Do App"),
          centerTitle: true,
          backgroundColor: Colors.yellowAccent,
          foregroundColor: Colors.black,
        ),
        body: (tasksProvider.isLoading == false)
            ? SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 10.0),
                    Expanded(
                      child: tasksProvider.tasks.isEmpty
                          ? SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Image.asset("assets/no_task.png"),
                                  ),
                                  Text("No tasks have been created")
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: tasksProvider.tasks.length,
                              itemBuilder: (context, index) {
                                Task currentTask = tasksProvider.tasks[index];
                                return CheckboxListTile(
                                  title: Text(
                                    currentTask.content!,
                                    style: TextStyle(
                                      decoration: currentTask.complete
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                  autofocus: false,
                                  secondary: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (dialogcontext) {
                                                return AlertDialog(
                                                    title: Text("Edit task"),
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextField(
                                                          controller:
                                                              contentController,
                                                          autofocus: true,
                                                          maxLines: null,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                UnderlineInputBorder(),
                                                          ),
                                                        ),
                                                        SizedBox(height: 10.0),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    dialogcontext);
                                                              },
                                                              child: Text(
                                                                  "Cancel"),
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black,
                                                                  foregroundColor:
                                                                      Colors
                                                                          .yellowAccent),
                                                            ),
                                                            SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                currentTask
                                                                        .content =
                                                                    contentController
                                                                        .text;
                                                                tasksProvider
                                                                    .updateTask(
                                                                        currentTask);
                                                                Navigator.pop(
                                                                    dialogcontext);
                                                              },
                                                              child:
                                                                  Text("Save"),
                                                              style: ElevatedButton.styleFrom(
                                                                  fixedSize:
                                                                      Size(90.0,
                                                                          5.0),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black,
                                                                  foregroundColor:
                                                                      Colors
                                                                          .yellowAccent),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ));
                                              });
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          tasksProvider.deleteTask(currentTask);
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: currentTask.complete,
                                  onChanged: (bool? value) {
                                    tasksProvider
                                        .toggleTaskCompletion(currentTask.id!);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            contentController.clear();
            showDialog(
                context: context,
                builder: (builder) {
                  return AlertDialog(
                      title: Text("Create a task"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: contentController,
                            autofocus: true,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              addNewTask();
                            },
                            child: Text("Create"),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.yellowAccent),
                          ),
                        ],
                      ));
                });
          },
          child: const Icon(Icons.add, size: 30.0),
          shape: CircleBorder(),
          foregroundColor: Colors.yellowAccent,
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
