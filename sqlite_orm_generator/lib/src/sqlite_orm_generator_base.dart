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

    final buffer = StringBuffer();
    final className = visitor.constructor.returnType;

    // Writing the header of mixin
    buffer.writeln("class ${className}ORM {");

    // Writing table creation SQL.
    buffer.write("final sql = ${getTableCreationSQL(visitor)};");

    // End mixin
    buffer.writeln("}");
    return buffer.toString();
  }

  String getTableCreationSQL(ModelVisitor visitor) {
    final buffer = StringBuffer();
    final className = visitor.constructor.returnType.toString();

    // Writingt the header
    buffer.writeln("'CREATE TABLE IF NOT EXISTS $className ('");

    for (final field in visitor.fieldElements) {
      final fieldIndex = visitor.fieldElements.indexOf(field);
      String line = "";
      for (final metadata in field.metadata) {
        final computedConstantValue = metadata.computeConstantValue();
        final fieldType = field.getter?.returnType.toString();
        line = "  ";
        if (computedConstantValue?.type.toString() == '$Column') {
          final name = computedConstantValue!.getField('name')?.toStringValue();

          // Defining the name of the column.
          // If the name of the column is not definig, the name of the field
          // will be setted as name to the column.
          if (name != null) {
            line += name;
          } else {
            line += field.name;
          }

          // Defining the type of the column.
          if (fieldType == '$String' || fieldType == '$String?') {
            line += " TEXT";
          } else if (fieldType == '$int' || fieldType == '$int?') {
            line += " INTEGER";
          } else if (fieldType == '$double' || fieldType == '$double?') {
            line += " REAL";
          }

          // Defining the column configurations.
          if (computedConstantValue.getField('primaryKey')!.toBoolValue()!) {
            line += " PRIMARY KEY";
          }
          if (computedConstantValue.getField('autoincrement')!.toBoolValue()!) {
            line += " AUTOINCREMENT";
          }
          final notNull =
              computedConstantValue.getField('notNull')?.toBoolValue();
          final notNullDefined = notNull != null && notNull;
          final notNullByField =
              notNull == null && fieldType != null && !fieldType.endsWith("?");
          if (notNullDefined || notNullByField) {
            line += " NOT NULL";
          }
        }
      }
      if (fieldIndex < visitor.fieldElements.length - 1) {
        line += ",";
      }
      buffer.writeln("'$line'");
    }

    // End
    buffer.writeln("')'");
    return buffer.toString();
  }
}
