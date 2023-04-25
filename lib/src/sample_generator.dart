// ignore_for_file: implementation_imports

import 'dart:convert';

import 'package:build/src/builder/build_step.dart';
import 'package:clean_annotation/annotations.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';

import 'dart:async';

import 'package:source_gen/source_gen.dart';

const TypeChecker _typeChecker = TypeChecker.fromRuntime(RepositoryAnnotation);

class SampleGenerator implements Generator {
  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final dartFile = Glob('**/injection.dart');

    var buffer = StringBuffer();
    // await for (final id in buildStep.findAssets(dartFile)) {
    //   final step = await buildStep.readAsString(id);
    //   buffer.writeln('// $id');
    // }
    final sample_list = [];

    for (final clazz in library.classes) {
      // if (clazz.source.shortName.contains('injection.dart')) {
      if (_typeChecker.hasAnnotationOfExact(clazz)) {
        sample_list.add(clazz.displayName);
        // buffer.writeln('// class Generated ${clazz.source.shortName} {}');
      }
      final encoded = jsonEncode(sample_list);
      buffer.writeln(encoded);
      // }
    }
    return buffer.toString();

    // for (final clazz in library.classes) {
    //   if (_typeChecker.hasAnnotationOfExact(clazz)) {
    //     buffer.writeln('// class Generated${clazz.source.shortName} {}');
    //     return buffer.toString();
    //   }
    // }
    // final classList = dartFile.listSync();
    // if (classList.isNotEmpty) {
    //   var buffer = StringBuffer();
    //   for (var item in dartFile.listSync()) {
    //     buffer.writeln(item);
    //   }
    //   final classes =
    //       library.annotatedWith(TypeChecker.fromRuntime(RepositoryAnnotation).ha);
    //   try {
    //     for (final aa in classes) {
    //       buffer.writeln('${aa.annotation.}');
    //     }
    //   } catch (e) {
    //     buffer.writeln('// $e');
    //   }
    //   // buffer.writeln('// $classes');
    //   // buffer.writeln('// ${classList}');

    //   // // library.allElements.forEach((element) {
    //   // //   buffer.writeln(
    //   // //       '// ${element.displayName} - ${element.source.fullName} - ${element.declaration}');
    //   // // });

    //   return buffer.toString();
    // }
    return null;
    // return buffer.toString();
  }
}
