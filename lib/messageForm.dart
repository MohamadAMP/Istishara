import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessageForm extends StatefulWidget {
  ValueChanged<String> onSubmit;

  MessageForm(this.onSubmit);
  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  String message;
  final controller = new TextEditingController();

  void click() {
    widget.onSubmit(message);
    message = '';
    controller.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: this.controller,
            decoration: InputDecoration(
              hintText: 'Type your message',
              prefixIcon: Icon(Icons.message),
            ),
            minLines: 1,
            maxLines: 20,
            onChanged: (value) => {
              setState(() {
                message = value;
              })
            },
          )),
          RawMaterialButton(
              onPressed: () {},
              child: IconButton(
                  icon: Icon(Icons.send),
                  splashColor: Colors.blue,
                  onPressed:
                      message == null || message.isEmpty ? null : this.click))
        ],
      ),
    );
  }
}
