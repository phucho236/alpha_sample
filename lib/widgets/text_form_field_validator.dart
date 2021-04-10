import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormFieldValidator extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final GlobalKey<FormState> globalKeyTextFormFieldPassWord;
  final bool isInputPass;
  final Function(String) validator;

  TextFormFieldValidator({
    @required this.textEditingController,
    @required this.hintText,
    @required this.globalKeyTextFormFieldPassWord,
    this.isInputPass = false,
    @required this.validator,
  });

  @override
  _TextFormFieldValidatorState createState() => _TextFormFieldValidatorState();
}

class _TextFormFieldValidatorState extends State<TextFormFieldValidator> {
  bool _hidePassWord = false;

  //final _globalKeyTextFormFieldPassWord = GlobalKey<FormState>();
  FocusNode focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      validator: widget.validator,
      controller: widget.textEditingController,
      onEditingComplete: () {
        if (widget.globalKeyTextFormFieldPassWord.currentState.validate() ==
            false) {
          focusNode.requestFocus();
        } else {
          focusNode.unfocus();
        }
      },
      obscureText: _hidePassWord,
      decoration: InputDecoration(
        isDense: true,
        labelText: widget.hintText,
        suffixIcon: widget.isInputPass
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    _hidePassWord = !_hidePassWord;
                  });
                },
                child: Icon(
                  Icons.remove_red_eye,
                  color: _hidePassWord ? Colors.grey : Colors.black,
                ),
              )
            : SizedBox(),
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
