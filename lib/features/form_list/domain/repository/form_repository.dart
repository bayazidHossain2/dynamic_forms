import 'package:dynamic_forms/core/errors/failures.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/dynamic_form.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class FormRepository {
  Future<Either<Failure, List<DynamicForm>>> getAllDynamicForm();
}
