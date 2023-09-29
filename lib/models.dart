class Task {
  final String title;
  final String description;
  final String urlImage;
  final DateTime date;

  //valor opcional en urlImage
  Task(
      {required this.title,
      required this.description,
      this.urlImage = "assets/images/note-task.png",
      required this.date});

  String toPrint() {
    String day = date.day.toString();
    String month = date.month.toString();
    String year = date.year.toString();
    return day + "/" + month + "/" + year;
  }
}
