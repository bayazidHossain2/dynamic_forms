import 'dart:io';
import 'dart:typed_data';
import 'package:dynamic_forms/features/form_list/domain/entities/dynamic_form.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfGeneratorService {
  final DynamicForm dynamicForm;
  final Map<String, dynamic> controllerMap;

  PdfGeneratorService({required this.dynamicForm, required this.controllerMap});

  Future<String> generateAndSavePDF(BuildContext context) async {
    // Request permission
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      print('Storage permission denied');
      return '';
    }

    // Create PDF document
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              dynamicForm.formName,
              style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 32),

            pw.ListView.builder(
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemCount: dynamicForm.sections.length,
              itemBuilder: (context, index) {
                final section = dynamicForm.sections[index];
                return pw.Container(
                  margin: pw.EdgeInsets.symmetric(vertical: 8),
                  padding: pw.EdgeInsets.symmetric(vertical: 8),
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(8),
                    color: PdfColor(0.95, 0.95, 0.95),
                  ),
                  child: pw.Container(
                    padding: pw.EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          section.name,
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Container(
                          margin: pw.EdgeInsets.symmetric(horizontal: 16),
                          child: pw.ListView.builder(
                            itemCount: section.fields.length,
                            itemBuilder: (context, index) {
                              final field = section.fields[index];
                              if (field.properties.type == 'text') {
                                return _getRow(
                                  label: field.properties.label.toString(),
                                  text: controllerMap[field.key].text,
                                );
                              } else if (field.properties.type ==
                                  'dropDownList') {
                                return _getRow(
                                  label: field.properties.label.toString(),
                                  text: controllerMap[field.key].text,
                                );
                              } else if (field.properties.type == 'yesno') {
                                return _getRow(
                                  label: field.properties.label.toString(),
                                  text: (controllerMap[field.key]!.value == 1)
                                      ? 'Yes'
                                      : 'No',
                                );
                              } else if (field.properties.type ==
                                  'checkBoxList') {
                                List<String> selected = [];
                                for (
                                  int i = 0;
                                  i < field.properties.listItems!.length;
                                  i++
                                ) {
                                  if (controllerMap[field.key][i].value) {
                                    selected.add(
                                      field.properties.listItems![i].name,
                                    );
                                  }
                                }
                                return _getRow(
                                  label: field.properties.label.toString(),
                                  text: selected.toString(),
                                );
                              }
                              // else if (field.properties.type == 'imageView') {
                              //   return pw.Column(
                              //     crossAxisAlignment:
                              //         pw.CrossAxisAlignment.start,
                              //     children: [
                              //       pw.Text(
                              //         field.properties.label.toString(),
                              //         style: pw.TextStyle(
                              //           fontSize: 16,
                              //           fontWeight: pw.FontWeight.bold,
                              //         ),
                              //       ),
                              //       pw.ListView.builder(
                              //         itemCount:
                              //             controllerMap[field.key]!.length,
                              //         itemBuilder: (context, index) {
                              //           return pw.Container(
                              //             padding: pw.EdgeInsets.all(4),
                              //             decoration: pw.BoxDecoration(
                              //               border: pw.Border.all(width: 2),
                              //             ),
                              //             margin: pw.EdgeInsets.all(8),
                              //             child: pw.Image(
                              //               pw.MemoryImage(
                              //                 controllerMap[field.key]![index],
                              //               ),
                              //             ),
                              //           );
                              //         },
                              //       ),
                              //     ],
                              //   );
                              // }
                              return pw.Text(field.key);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );

    Uint8List bytes = await pdf.save();

    // Use a directory that your app is allowed to access
    Directory? directory = await getExternalStorageDirectory();

    // Optional: Make a subfolder
    final path = Directory('${directory!.path}/MyAppDocuments');
    if (!await path.exists()) {
      await path.create(recursive: true);
    }

    // Save the file
    final file = File(
      '${path.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(bytes);

    print('PDF saved at: ${file.path}');
    return file.path;
  }
}

dynamic _getRow({required String label, required String text}) {
  return pw.Container(
    margin: pw.EdgeInsets.symmetric(vertical: 4),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 3,
          child: pw.Text(
            label.toString(),
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(width: 4),
        pw.Expanded(child: pw.Text(text)),
      ],
    ),
  );
}
