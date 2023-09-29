import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/models.dart';

class TaskState {
  final List<Task> tasks;

  TaskState(this.tasks);
}

abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;

  AddTaskEvent(this.title, this.description, this.date,
      {this.imageUrl = 'assets/images/note-task.png'});
}

class DeleteTaskEvent extends TaskEvent {
  final Task task;

  DeleteTaskEvent(this.task);
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState([]));

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is AddTaskEvent) {
      // Aquí manejas la lógica para agregar una tarea
      // Puedes usar event.title, event.description y event.timestamp
      final updatedTasks = List.of(state.tasks);
      updatedTasks.add(
        Task(
            title: event.title,
            description: event.description,
            date: DateTime.now()),
      );
      yield TaskState(updatedTasks);
    } else if (event is DeleteTaskEvent) {
      // Aquí manejas la lógica para eliminar una tarea
      final updatedTasks = List.of(state.tasks);
      updatedTasks.remove(event.task);
      yield TaskState(updatedTasks);
    }
    // Puedes manejar otros eventos aquí si es necesario
  }
}
