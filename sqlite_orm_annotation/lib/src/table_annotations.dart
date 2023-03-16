import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

@sealed
@Target({TargetKind.classType})
class Table {
  final String? name;

  /// This is the annotation used to define that a class will be a table in the
  /// database.
  ///
  /// The [name] parameter defines what the name of the table will be, if the
  /// parameter is null the name of the table will be the name of the marked
  /// class.
  const Table({
    this.name,
  });
}

@sealed
@Target({TargetKind.field})
class Column<T> {
  final String? name;
  final bool primaryKey;
  final bool autoincrement;
  final bool notNull;
  final int? length;
  final int decimal;
  final T? defaultValue;

  /// This is the annotation used to define that a field will be a column in the
  /// table.
  ///
  /// The [name] parameter defines what the name of the column will be, if the
  /// parameter is null the name of the column will be the name of the marked
  /// field.
  const Column({
    this.name,
    this.primaryKey = false,
    this.autoincrement = false,
    this.notNull = false,
    this.length,
    this.decimal = 2,
    this.defaultValue,
  });
}
