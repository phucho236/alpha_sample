import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/views/qr_code/create_qr_code_page.dart';
import 'package:alpha_sample/widgets/container/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRCodeLayout extends StatefulWidget {
  static const String routeName = "/QRCodeLayout";

  @override
  _QRCodeLayoutState createState() => _QRCodeLayoutState();
}

class _QRCodeLayoutState extends State<QRCodeLayout> {
  String cameraScanResult = "";
  bool showCreateQRCode = true;
  bool showScanQRCode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ASAppBar(title: qrCodeLabel(context)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showCreateQRCode
              ? MaterialButton(
                  color: Colors.blueGrey,
                  onPressed: () {
                    Navigator.pushNamed(context, CreateQRCodePage.routeName);
                  },
                  child: Text(createQRCodeLabel(context)),
                )
              : Container(),
          showScanQRCode
              ? MaterialButton(
                  color: Colors.blueGrey,
                  onPressed: () async {
                    await scanQR();
                  },
                  child: Text(scanQRCodeLabel(context)),
                )
              : Container(),
          Text(cameraScanResult != null ? "$cameraScanResult" : ""),
        ],
      ),
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR);
    if (barcodeScanRes != null)
      setState(() => cameraScanResult = barcodeScanRes);
  }
}
