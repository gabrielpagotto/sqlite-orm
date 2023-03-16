import 'package:sqlite_orm_annotation/sqlite_orm_annotation.dart';

part 'user.g.dart';

@Table()
class User {
  @Column(primaryKey: true, autoincrement: true, notNull: true)
  int? id;

  @Column(notNull: true, length: 16)
  String? name;

  @Column(length: 32)
  String? surname;
}
