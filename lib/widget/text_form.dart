import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';

class TextForm extends StatefulWidget {
  String title;
  TextEditingController controller = TextEditingController();
  String validatorMessage;
  int lengthLimitingTextInputFormatter;
  String regExPattern;
  TextInputType textInputType;
  TextInputAction textInputAction;
  String formHintText;

  TextForm({
    required this.title,
    required this.controller,
    required this.validatorMessage,
    required this.lengthLimitingTextInputFormatter,
    required this.regExPattern,
    required this.textInputType,
    required this.textInputAction,
    required this.formHintText,
  });

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: widget.controller,
          validator: (value) {
            if (widget.controller.text.isEmpty) {
              showMessage(widget.validatorMessage);
            }
            return null;
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.lengthLimitingTextInputFormatter),
            FilteringTextInputFormatter.allow(RegExp(widget.regExPattern))
          ],
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          decoration:
              InputDecoration(hintText: widget.formHintText, border: InputBorder.none),
        ),
        Divider(),
      ],
    );
  }
}
