import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

class ModelVisitor extends SimpleElementVisitor<dynamic> {
  late String className;

  Map<String, dynamic> fields = <String, dynamic>{};

  @override
  dynamic visitConstructorElement(ConstructorElement element) {
    final elementReturnType = element.type.returnType.toString();

    className = elementReturnType.replaceFirst('*', '');
  }

  @override
  dynamic visitFieldElement(FieldElement element) {
    final elementType = element.type.toString();

    fields[element.name] = elementType.replaceFirst('*', '');
  }
}
