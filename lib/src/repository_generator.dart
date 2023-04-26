// ignore_for_file: depend_on_referenced_packages

import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';

import 'package:source_gen/source_gen.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';

import 'package:clean_annotation/annotations.dart';

// import 'model_visitor.dart';

class RepositoryGenerator extends GeneratorForAnnotation<RepositoryAnnotation> {
  // 1
  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final className = element.displayName;
    final lib = Library(
      (b) => b
        ..comments.addAll(
          [
            '*** generated repository file ***',
          ],
        )
        ..body.addAll(
          [
            Class((c) => c.name = 'Generated$className'),
          ],
        ),
    );

    final emitter = DartEmitter(
      allocator: Allocator.simplePrefixing(),
      orderDirectives: true,
    );

    final output = DartFormatter().format(lib.accept(emitter).toString());
    return output;
    // final visitor = ModelVisitor();
    // element.visitChildren(visitor);

    // // EX: 'GeneratedRepository' for 'Repository'.
    // final className = 'Genereted${visitor.className}';

    // final classBuffer = StringBuffer();

    // classBuffer.writeln('class $className {');
    // classBuffer.writeln('//gen test==> ${element.children}');

    // classBuffer.writeln('Map<String, dynamic> variables = {};');

    // classBuffer.writeln('$className() {');

    // for (final field in visitor.fields.keys) {
    //   // remove '_' from private variables
    //   final variable =
    //       field.startsWith('_') ? field.replaceFirst('_', '') : field;

    //   classBuffer.writeln("variables['${variable}'] = super.$field;");
    //   // EX: variables['name'] = super._name;
    // }

    // classBuffer.writeln('}');

    // generateGettersAndSetters(visitor, classBuffer);

    // classBuffer.writeln('}');

    // return classBuffer.toString();
  }

  // void generateGettersAndSetters(
  //     ModelVisitor visitor, StringBuffer classBuffer) {
  //   for (final field in visitor.fields.keys) {
  //     final variable =
  //         field.startsWith('_') ? field.replaceFirst('_', '') : field;

  //     classBuffer.writeln(
  //         "${visitor.fields[field]} get $variable => variables['$variable'];");
  //     // EX: String get name => variables['name'];

  //     classBuffer
  //         .writeln('set $variable(${visitor.fields[field]} $variable) {');
  //     classBuffer.writeln('super.$field = $variable;');
  //     classBuffer.writeln("variables['$variable'] = $variable;");
  //     classBuffer.writeln('}');

  //     // EX: set name(String name) {
  //     //       super._name = name;
  //     //       variables['name'] = name;
  //     //     }
  //   }
  // }
}
