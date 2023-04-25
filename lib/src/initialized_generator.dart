import 'dart:convert';

import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:glob/glob.dart';

import 'package:dart_style/dart_style.dart';

import 'package:source_gen/source_gen.dart';

import 'package:clean_annotation/annotations.dart';

import 'model_visitor.dart';

class InitializedGenerator
    extends GeneratorForAnnotation<InitializedAnnotation> {
  // 1
  @override
  dynamic generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final dartFiles = Glob('lib/src/**.sample.dart');

    // final classBuffer = StringBuffer();
    // classBuffer.writeln('// ***** generated ******');
    // classBuffer.writeln('// ***** ${dartFiles.listSync()}');
    // final asset = await buildStep.findAssets(dartFiles).first;
    // classBuffer.writeln('// ***** asset --> $asset');

    // await for (var id in buildStep.findAssets(dartFiles)) {
    //   final step = await buildStep.readAsString(id);
    //   classBuffer.writeln(step);
    // }
    // return classBuffer.toString();

    final lib = Library(
      (b) => b
        ..comments.addAll(
          [
            '*** generated',
          ],
        )
        ..body.addAll(
          [
            Class((c) => c.name = 'Aaa'),
          ],
        )
        ..directives.addAll(
          [
            Directive.import('aaa'),
          ],
        ),
    );

    final emitter = DartEmitter(
      allocator: Allocator.simplePrefixing(),
      orderDirectives: true,
    );

    final output = DartFormatter().format(lib.accept(emitter).toString());

    return output;
  }

  void generateGettersAndSetters(
      ModelVisitor visitor, StringBuffer classBuffer) {
    for (final field in visitor.fields.keys) {
      final variable =
          field.startsWith('_') ? field.replaceFirst('_', '') : field;

      classBuffer.writeln(
          "${visitor.fields[field]} get $variable => variables['$variable'];");
      // EX: String get name => variables['name'];

      classBuffer
          .writeln('set $variable(${visitor.fields[field]} $variable) {');
      classBuffer.writeln('super.$field = $variable;');
      classBuffer.writeln("variables['$variable'] = $variable;");
      classBuffer.writeln('}');

      // EX: set name(String name) {
      //       super._name = name;
      //       variables['name'] = name;
      //     }
    }
  }
}
