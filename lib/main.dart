import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/models.dart';
import 'package:to_do/screens/task_detail_screen.dart';
import 'package:to_do/state.dart';

void main() {
  runApp(const MyApp());
}

enum SettingsItem { itemOne, itemTwo, itemThree }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TaskBloc(),
        child: MaterialApp(
          title: 'To Do',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Quicksand',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
            useMaterial3: true,
          ),
          home: HomePage(),
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final blockProvider = BlocProvider.of<TaskBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("TO DO APP")),
      body: TaskList(taskBloc: blockProvider),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Muestra un diálogo para agregar una nueva tarea
          showDialog(
            context: context,
            builder: (context) {
              final titleController = TextEditingController();

              return AlertDialog(
                title: Text('Agregar Tarea'),
                content: TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Título de la Tarea'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(
                          titleController.text, 'prueba', DateTime.now()));
                      Navigator.of(context).pop();
                    },
                    child: Text('Agregar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancelar'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final TaskBloc taskBloc;

  const TaskList({super.key, required this.taskBloc});
  final bool done = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: taskBloc.state.tasks.length,
        itemBuilder: (context, index) {
          final task = taskBloc.state.tasks[index];
          return TaskCard(task: task);
        });
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskDetail(task: task)));
          },
          child: Row(
            children: [
              Image.asset(
                task.urlImage,
                width: 40,
              ),
              const SizedBox(
                width: 20,
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title,
                      style: const TextStyle(
                          fontFamily: 'Quicksand-bold', fontSize: 16)),
                  Text(task.description, style: const TextStyle(fontSize: 14)),
                ],
              ),
              Spacer(),
              Text(task.toPrint()),
              PopMenuTask(task: task),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

class PopMenuTask extends StatefulWidget {
  final Task task;
  const PopMenuTask({super.key, required this.task});

  @override
  State<PopMenuTask> createState() => _PopMenuTaskState();
}

class _PopMenuTaskState extends State<PopMenuTask> {
  SettingsItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SettingsItem>(
        initialValue: selectedMenu,
        onSelected: (SettingsItem item) {
          setState(() {
            selectedMenu = item;
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<SettingsItem>>[
              const PopupMenuItem<SettingsItem>(
                value: SettingsItem.itemOne,
                child: Text('Hecho'),
              ),
              PopupMenuItem<SettingsItem>(
                value: SettingsItem.itemTwo,
                child: Text('Eliminar'),
                onTap: () {
                  BlocProvider.of<TaskBloc>(context)
                      .add(DeleteTaskEvent(widget.task));
                },
              ),
              const PopupMenuItem<SettingsItem>(
                value: SettingsItem.itemThree,
                child: Text('Modificar'),
              ),
            ]);
  }
}
