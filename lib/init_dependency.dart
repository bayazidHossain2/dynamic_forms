import 'package:dynamic_forms/features/form_list/data/datasources/json_load_data_source/json_load_data_source.dart';
import 'package:dynamic_forms/features/form_list/data/repositories/form_repository_impl.dart';
import 'package:dynamic_forms/features/form_list/domain/repository/form_repository.dart';
import 'package:dynamic_forms/features/form_list/domain/usecases/get_all_json_form_usecase.dart';
import 'package:dynamic_forms/features/form_list/presentation/bloc/dynamic_form_bloc.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initFormBloc();
}

void _initFormBloc() {
  serviceLocator
    // Data Source
    ..registerFactory<JsonLoadDataSource>(() => JsonLoadDataSourceImpl())
    // Repository
    ..registerFactory<FormRepository>(
      () => FormRepositoryImpl(dataSource: serviceLocator()),
    )
    // Usecase
    ..registerFactory(() => GetAllJsonFormUsecase(repository: serviceLocator()))
    // Bloc
    ..registerLazySingleton(
      () => DynamicFormBloc(getAllJsonFormUsecase: serviceLocator()),
    );
}
