import 'package:dynamic_forms/core/errors/exceptions.dart';
import 'package:dynamic_forms/core/errors/failures.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/dynamic_form.dart';
import 'package:dynamic_forms/features/form_list/domain/repository/form_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../datasources/json_load_data_source/json_load_data_source.dart';

class FormRepositoryImpl implements FormRepository {
  final JsonLoadDataSource dataSource;

  FormRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<DynamicForm>>> getAllDynamicForm() async {
    try {
      return right(await dataSource.getAllDynamicForm());
    } on LocalException catch (e) {
      return left(Failure(e.message));
    }
  }
}
