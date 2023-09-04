import 'package:drift/drift.dart';

class Reminder extends Table {
  IntColumn get id => integer().autoIncrement()(); 
  TextColumn get title => text()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  BoolColumn get timeSelected => boolean().withDefault(const Constant(false))();
  DateTimeColumn get dateAndTime => dateTime().nullable()();
}