import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberField extends StatefulWidget {
  NumberField({Key? key, required this.labelText, this.onChanged})
      : super(key: key);

  final String labelText;
  final onChanged;

  @override
  _NumberField createState() =>
      new _NumberField(labelText: this.labelText, onChanged: this.onChanged);
}

class _NumberField extends State<NumberField> {
  _NumberField({required this.labelText, this.onChanged});
  var value = TextEditingController();

  final labelText;
  final onChanged;

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    value.addListener(_changeARes);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    value.dispose();
    super.dispose();
  }

  void _changeARes() {
    if (value.text == "") {
      setState(() {
        value.text = "0";
      });
    } else if (value.text[0] == "0" && value.text.length > 1) {
      setState(() {
        value.text = value.text.substring(1, value.text.length);
      });
    }
    //Check if textfield has an dot
    if (".".allMatches(value.text).length == 2) {
      value.text = value.text.substring(0, value.text.length - 1);
    }
    value.selection =
        TextSelection.fromPosition(TextPosition(offset: value.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: new InputDecoration(labelText: labelText),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
      ],
      onChanged: onChanged,
      controller: value,
    );
  }
}
