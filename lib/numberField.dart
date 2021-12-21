import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberField extends StatefulWidget {
  NumberField(
      {Key? key, required this.labelText, this.onChanged, this.controller})
      : super(key: key);

  final String labelText;
  final onChanged;
  final controller;

  @override
  _NumberField createState() => new _NumberField(
      labelText: this.labelText,
      onChanged: this.onChanged,
      controller: this.controller);
}

class _NumberField extends State<NumberField> {
  _NumberField({required this.labelText, this.onChanged, this.controller});

  final labelText;
  final onChanged;
  var controller;

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    if (controller != null) {
      controller.addListener(_changeARes);
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    super.dispose();
  }

  void _changeARes() {
    var txt = controller.text;
    if (txt.length > 1) {
      if (txt[0] == "0" && txt.length > 1 && txt[1] != ".") {
        controller.text = txt.substring(1);
      } else if (txt[0] == "-" &&
          txt[1] == "0" &&
          txt[2] != "." &&
          txt.length > 2) {
        controller.text = txt.substring(txt.length - 1);
      }
    }
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: new InputDecoration(labelText: labelText),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('^[0-9,]*\\.?[0-9,]*\$')),
      ],
      onChanged: onChanged,
      controller: controller,
    );
  }
}
