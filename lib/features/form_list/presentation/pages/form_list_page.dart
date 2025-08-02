import 'package:dynamic_forms/core/services/json_loader/json_loader_service.dart';
import 'package:flutter/material.dart';

class FormListPage extends StatefulWidget {
  const FormListPage({super.key});

  @override
  State<FormListPage> createState() => _FormListPageState();
}

class _FormListPageState extends State<FormListPage> {
  bool isLoading = true;
  List<dynamic> formList = [];

  @override
  void initState() {
    super.initState();
    _asyncInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Form List'))),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: formList.length,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                child: Card(
                  color: Colors.green.shade50,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: Text(formList[index]['id'].toString()),
                    ),
                    title: Text(formList[index]['formName']),
                  ),
                ),
              ),
            ),
    );
  }

  void _asyncInit() async {
    for (int i = 1; i <= 3; i++) {
      final json = await JsonLoaderService.load(fileName: 'form_$i');
      formList.add(json);
    }
    setState(() {
      isLoading = false;
    });
  }
}
