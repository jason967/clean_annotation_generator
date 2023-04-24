import 'package:build/build.dart';
import 'package:clean_annotation_generator/src/autowired_generator.dart';
import 'package:clean_annotation_generator/src/repository_generator.dart';
import 'package:clean_annotation_generator/src/sample_generator.dart';
import 'package:clean_annotation_generator/src/usecase_generator.dart';

import 'package:source_gen/source_gen.dart';

//@repository
Builder generateRepository(BuilderOptions options) =>
    SharedPartBuilder([RepositoryGenerator()], 'j');

Builder generateSample(BuilderOptions options) =>
    LibraryBuilder(SampleGenerator(), generatedExtension: '.sample.dart');

// Builder generateRepository() {
//   return LibraryBuilder(RepositoryGenerator(),
//       generatedExtension: '.config.dart');
// }

//@usecase
Builder generateUsecase(BuilderOptions options) =>
    SharedPartBuilder([UsecaseGenerator()], 'usecase_generator');

//@autowired
Builder generateAutowired(BuilderOptions options) =>
    SharedPartBuilder([AutowiredGenerator()], 'autowired_generator');
