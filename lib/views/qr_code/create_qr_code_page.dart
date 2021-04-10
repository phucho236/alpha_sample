import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/utils/validators_utils.dart';
import 'package:alpha_sample/views/qr_code/qr_code_widget.dart';
import 'package:alpha_sample/widgets/container/app_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateQRCodePage extends StatefulWidget {
  static const String routeName = "/QRCodePage";

  @override
  _CreateQRCodePageState createState() => _CreateQRCodePageState();
}

class _CreateQRCodePageState extends State<CreateQRCodePage> {
  final _globalKeyQRCodePage = GlobalKey<FormState>();
  QRCodeWidget qRCodeWidget = QRCodeWidget();
  TextEditingController textEditingControllerDataQRCode =
      TextEditingController(text: '');
  String linkImages =
      "https://scontent.fsgn2-6.fna.fbcdn.net/v/t1.0-9/79857788_105204487637521_3876516479255969792_n.png?_nc_cat=100&_nc_sid=09cbfe&_nc_ohc=WcbZRi9ueQwAX_5pMXM&_nc_ht=scontent.fsgn2-6.fna&oh=e0981bcc17fe94bab16aee5d3d5b2693&oe=5F9A5204";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ASAppBar(
        showBack: true,
        title: createQRCodeLabel(context),
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Form(
            key: _globalKeyQRCodePage,
            child: TextFormField(
              controller: textEditingControllerDataQRCode,
              validator: (value) {
                return checkDataGenQRCode(value)
                    ? null
                    : errCreateQRCodeLabel(context);
              },
              decoration:
                  InputDecoration(labelText: dataCreateQRCodeLabel(context)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          textEditingControllerDataQRCode.text != ''
              ? qRCodeWidget.qrCodeWidget(
                  data: textEditingControllerDataQRCode.text,
                  isNetWorkImages: true,
                  networkOrAssetImages: linkImages,
                  sizeWidget: 200)
              : Container(
                  height: 200,
                  width: 200,
                ),
          RaisedButton(
            onPressed: () {
              if (_globalKeyQRCodePage.currentState.validate()) {
                setState(() {});
              } else {
                textEditingControllerDataQRCode.text = "";
                setState(() {});
              }
            },
            child: Text(submitLabel(context)),
          )
        ],
      ),
    );
  }
}
