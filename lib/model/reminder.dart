class Reminder {
  String title;
  String? date;
  String? time;
  bool isCompleted;

  Reminder({
    required this.title,
    this.date,
    this.time,
    this.isCompleted = false,
  });

  void toggleCompleted(){
    isCompleted = !isCompleted;
  }
}
