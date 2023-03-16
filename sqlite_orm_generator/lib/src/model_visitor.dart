import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  late final ConstructorElement constructor;
  final fieldElements = <FieldElement>[];

  @override
  void visitConstructorElement(ConstructorElement element) {
    constructor = element;
  }

  @override
  void visitFieldElement(FieldElement element) {
    fieldElements.add(element);
  }
}
