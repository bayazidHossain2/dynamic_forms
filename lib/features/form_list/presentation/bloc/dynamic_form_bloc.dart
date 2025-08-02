import 'dart:async';

import 'package:dynamic_forms/core/usecase/usecase.dart';
import 'package:dynamic_forms/features/form_list/domain/entities/dynamic_form.dart';
import 'package:dynamic_forms/features/form_list/domain/usecases/get_all_json_form_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dynamic_form_event.dart';
part 'dynamic_form_state.dart';

class DynamicFormBloc extends Bloc<DynamicFormEvent, DynamicFormState> {
  final GetAllJsonFormUsecase _getAllJsonFormUsecase;

  DynamicFormBloc({required GetAllJsonFormUsecase getAllJsonFormUsecase})
    : _getAllJsonFormUsecase = getAllJsonFormUsecase,
      super(DynamicFormInitialState()) {
    on<DynamicFormEvent>((_, emit) {
      emit(DynamicFormLoadingState());
    });
    on<DynamicFormGetAllJsonFormsEvent>(_onGetAllDynamicForm);
  }

  FutureOr<void> _onGetAllDynamicForm(
      DynamicFormGetAllJsonFormsEvent event,
    Emitter<DynamicFormState> emit,
  ) async {
    final res = await _getAllJsonFormUsecase(NoParams());

    res.fold(
      (l) => emit(DynamicFormFailureState(message: l.message)),
      (r) => emit(DynamicFormGetAllSuccessState(dynamicFormList: r)),
    );
  }
}
