// ignore_for_file: implementation_imports

import 'dart:convert';

import 'package:build/src/builder/build_step.dart';
import 'package:clean_annotation/annotations.dart';

import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

import 'dart:async';

import 'package:source_gen/source_gen.dart';

import '../builder.dart';

const TypeChecker _typeChecker = TypeChecker.fromRuntime(RepositoryAnnotation);

class SampleGenerator implements Generator {
  TypeChecker get isRepository =>
      const TypeChecker.fromRuntime(RepositoryAnnotation);

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    // final values = <String>{};
    var buffer = StringBuffer();
    buffer.writeln('${++Index().index}');

    // try {
    //   buffer.writeln('${library.element}');
    // } catch (e) {
    //   buffer.writeln('$e');
    // }
    // return buffer.toString();

    // for (var annotatedElement in library.annotatedWith(_typeChecker)) {
    //   buffer.writeln('// gg ${library.toString()}');
    //   // buffer.writeln(
    //   //     '// annotation : ${annotatedElement.annotation.}');
    //   buffer.writeln('// element : ${annotatedElement.element.library!.name}');
    // }

    buffer.writeln(
        '// len: ${library.allElements.length}, lib : ${library.element.source.shortName}');
    // for (final clazz in library.allElements) {
    //   buffer.write('// kkk  ${clazz.source} \n');

    //   // if (clazz.source.shortName.contains('injection.dart')) {
    //   //   return buffer.toString();
    //   // }
    // }
    return buffer.toString();

    // return null;

    // return values.join('\n\n');

    // final dartFile = Glob('lib/injection.dart');
    // // final isInjection = dartFile.listSync().isNotEmpty;
    // var buffer = StringBuffer();
    // buffer.writeln('${dartFile.listSync()}');
    // // await for (final id in buildStep.findAssets(dartFile)) {
    // //   final step = await buildStep.readAsString(id);
    // //   buffer.writeln('// $id');
    // // }
    // final sample_list = [];

    // for (final clazz in library.classes) {
    //   if (_typeChecker.hasAnnotationOfExact(clazz)) {
    //     sample_list.add(clazz.displayName);
    //   }
    //   final encoded = jsonEncode(sample_list);
    //   buffer.writeln(encoded);
    // }

    // return buffer.toString();
  }
}
