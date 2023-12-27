import 'package:flutter/material.dart';

class TextFieldWithFilter extends StatefulWidget {
  final String labelText;
  const TextFieldWithFilter({Key? key, required this.labelText})
      : super(key: key);

  @override
  _TextFieldWithFilterState createState() => _TextFieldWithFilterState();
}

class _TextFieldWithFilterState extends State<TextFieldWithFilter> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        controller: _textController,
        onChanged: (value) {},
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
