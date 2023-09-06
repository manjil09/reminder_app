import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:reminder_app/database/reminder_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Reminder])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Future<List<ReminderData>> getAllReminder() => select(reminder).get();
  
  Stream<List<ReminderData>> watchAllReminder() => select(reminder).watch();

  Future<int> countRows() async {
    var countExp = reminder.id.count();

    final query = selectOnly(reminder)..addColumns([countExp]);
    var result = await query.map((row) => row.read(countExp)).getSingle();
    return result ?? 0;
  }

  Future<int> countRemaining() async{
    var countExp = countAll(filter: reminder.isCompleted.equals(false));

    final query = selectOnly(reminder)..addColumns([countExp]);
    var result = await query.map((row) => row.read(countExp)).getSingle();
    return result ?? 0;
  }

  Future<int> addReminder(ReminderData reminderData) {
    return into(reminder).insert(reminderData);
  }

  Future<List<ReminderData>> getReminderById(int id) {
    return (select(reminder)..where((tbl) => tbl.id.equals(id))).get();
  }

  Future updateReminder(int id, ReminderData reminderData) {
    return (update(reminder)..where((tbl) => tbl.id.equals(id))).write(
      ReminderData(
        title: reminderData.title,
        id: reminderData.id,
        isCompleted: reminderData.isCompleted,
        timeSelected: reminderData.timeSelected,
        dateAndTime: reminderData.dateAndTime,
      ),
    );
  }

  Future deleteReminderById(int id) {
    return (delete(reminder)..where((tbl) => tbl.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'reminder.db'));
    return NativeDatabase.createInBackground(file);
  });
}
