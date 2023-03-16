import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sqlite_orm_generator/sqlite_orm_generator.dart';

Builder tableBuilder(BuilderOptions options) =>
    SharedPartBuilder([SQLiteOrmGenerator()], 'SQLiteOrmGenerator');
