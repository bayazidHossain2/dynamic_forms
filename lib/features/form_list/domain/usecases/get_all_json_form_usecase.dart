import 'package:dynamic_forms/core/errors/failures.dart';
import 'package:dynamic_forms/core/usecase/usecase.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/dynamic_form.dart';
import 'package:dynamic_forms/features/form_list/domain/repository/form_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllJsonFormUsecase implements UseCase<List<DynamicForm>, NoParams> {
  final FormRepository repository;

  const GetAllJsonFormUsecase({required this.repository});

  @override
  Future<Either<Failure, List<DynamicForm>>> call(NoParams noParams) async {
    return await repository.getAllDynamicForm();
  }
}
