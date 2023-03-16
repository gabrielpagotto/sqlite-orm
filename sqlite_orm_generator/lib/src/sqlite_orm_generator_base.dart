import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sqlite_orm_annotation/sqlite_orm_annotation.dart';
import 'package:sqlite_orm_generator/src/model_visitor.dart';

class SQLiteOrmGenerator extends GeneratorForAnnotation<Table> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
  }
}
