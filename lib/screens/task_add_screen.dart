import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/state.dart';

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({super.key});

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Task")),
        body: BlocProvider(
          create: (context) => TaskBloc(),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Titulo de la tarea",
                      style: TextStyle(fontFamily: 'Quicksand-bold')),
                  TextField(
                    controller: _controllerTitle,
                    decoration:
                        const InputDecoration(labelText: 'Ingresa un titulo'),
                  ),
                  const Text("Descripcion de la tarea",
                      style: TextStyle(fontFamily: 'Quicksand-bold')),
                  TextField(
                    controller: _controllerDescription,
                    decoration:
                        const InputDecoration(labelText: 'Ingresa un texto'),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {},
                          child: const Text("Eliminar Tarea")),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(
                                _controllerTitle.text,
                                _controllerDescription.text,
                                DateTime.now()));
                            Navigator.of(context).pop();
                          },
                          child: const Text("Guardar Tarea")),
                    ],
                  )
                ],
              ),
            ),
          )),
        ));
  }
}
