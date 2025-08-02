part of 'dynamic_form_bloc.dart';

@immutable
sealed class DynamicFormState {
  const DynamicFormState();
}

final class DynamicFormInitialState extends DynamicFormState {}

final class DynamicFormLoadingState extends DynamicFormState {}

final class DynamicFormFailureState extends DynamicFormState {
  final String message;

  const DynamicFormFailureState({required this.message});
}

final class DynamicFormGetAllSuccessState extends DynamicFormState {
  final List<DynamicForm> dynamicFormList;

  const DynamicFormGetAllSuccessState({required this.dynamicFormList});
}
