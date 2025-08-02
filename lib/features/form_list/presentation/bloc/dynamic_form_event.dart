part of 'dynamic_form_bloc.dart';

@immutable
sealed class DynamicFormEvent {}

final class DynamicFormGetAllJsonFormsEvent extends DynamicFormEvent {}
