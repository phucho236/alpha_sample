import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';

class QRCodeWidget {
  Widget qrCodeWidget(
      {bool isNetWorkImages = true,
      String networkOrAssetImages,
      @required String data,
      double sizeWidget}) {
    return PrettyQr(
        image: networkOrAssetImages == null
            ? null
            : isNetWorkImages
                ? NetworkImage(networkOrAssetImages)
                : AssetImage(networkOrAssetImages),
        typeNumber: 3,
        size: sizeWidget,
        data: data, //in put max 40
        errorCorrectLevel: QrErrorCorrectLevel.M,
        roundEdges: true);
  }
}
