import 'package:dynamic_forms/features/form_list/presentation/bloc/dynamic_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormListPage extends StatefulWidget {
  const FormListPage({super.key});

  @override
  State<FormListPage> createState() => _FormListPageState();
}

class _FormListPageState extends State<FormListPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // _asyncInit();
    context.read<DynamicFormBloc>().add(DynamicFormGetAllJsonFormsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Form List'))),
      body: BlocConsumer<DynamicFormBloc, DynamicFormState>(
        listener: (context, state) {
          if (state is DynamicFormFailureState) {
            // showSnackBar(
            // context: context,
            // message: state.message,
            // backgroundColor: AppPallete.dangerColor,
            // );
          }
        },
        builder: (context, state) {
          if (state is DynamicFormLoadingState) {
            return CircularProgressIndicator();
          } else if (state is DynamicFormGetAllSuccessState) {
            return ListView.builder(
              itemCount: state.dynamicFormList.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Card(
                  color: Colors.green.shade50,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: Text(state.dynamicFormList[index].id.toString()),
                    ),
                    title: Text(state.dynamicFormList[index].formName),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text('Some thing wrong'));
          }
        },
      ),
    );
  }
}
