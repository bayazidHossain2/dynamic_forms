import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Radio, Colors;

class CustomRadioButtonWidget extends FormField<int> {
  CustomRadioButtonWidget({
    super.key,
    required String label,
    bool? isColumn,
    FormFieldSetter<int>? onSaved,
    int? initialValue,
  }) : super(
         validator: (value) {
           if (value == null) {
             return "Please select an option.";
           }
           return null;
         },
         onSaved: onSaved,
         initialValue: initialValue,
         builder: (FormFieldState<int> state) {
           final options = {1: 'Yes', 2: 'No'};

           List<Widget> children = options.entries.map((entry) {
             return GestureDetector(
               onTap: () {
                 state.didChange(entry.key);
               },
               child: Row(
                 children: [
                   Radio<int>(
                     value: entry.key,
                     groupValue: state.value,
                     onChanged: (val) => state.didChange(val),
                   ),
                   Text(entry.value),
                 ],
               ),
             );
           }).toList();

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SmallTitle(title: label),
               (isColumn == true)
                   ? Column(children: children)
                   : Row(children: children),
               if (state.hasError)
                 Padding(
                   padding: const EdgeInsets.only(top: 4.0),
                   child: Text(
                     state.errorText ?? '',
                     style: TextStyle(color: Colors.red[700], fontSize: 12),
                   ),
                 ),
             ],
           );
         },
       );
}

class SmallTitle extends StatelessWidget {
  final String title;

  const SmallTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
