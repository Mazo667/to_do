import 'package:flutter/material.dart';
import 'package:to_do/models.dart';

class TaskDetail extends StatelessWidget {
  final Task task;
  const TaskDetail({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              task.urlImage,
              width: 200,
            ),
            const SizedBox(height: 20, width: double.infinity),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(task.description),
              ),
            ),
            const SizedBox(height: 20, width: double.infinity),
            Text(task.toPrint()),
          ],
        ),
      ),
    );
  }
}
