import 'package:build/build.dart';
import 'package:clean_annotation_generator/src/autowired_generator.dart';
import 'package:clean_annotation_generator/src/initialized_generator.dart';
import 'package:clean_annotation_generator/src/repository_generator.dart';
import 'package:clean_annotation_generator/src/sample_generator.dart';
import 'package:clean_annotation_generator/src/usecase_generator.dart';

import 'package:source_gen/source_gen.dart';

class Index {
  int index = 0;
  static final Index _instance = Index._internal();

  factory Index() => _instance;

  Index._internal();
}

//@repository
Builder generateRepository(BuilderOptions options) =>
    LibraryBuilder(RepositoryGenerator(),
        generatedExtension: '.repository.dart');

// @InitializedAnnotation()
Builder generateInitialize(BuilderOptions options) =>
    LibraryBuilder(InitializedGenerator(), generatedExtension: '.init.dart');

//@repository
// Builder generateSample(BuilderOptions options) =>
//     LibraryBuilder(SampleGenerator(), generatedExtension: '.sample.json');

//@usecase
Builder generateUsecase(BuilderOptions options) =>
    SharedPartBuilder([UsecaseGenerator()], 'usecase_generator');

//@autowired
Builder generateAutowired(BuilderOptions options) =>
    SharedPartBuilder([AutowiredGenerator()], 'autowired_generator');
