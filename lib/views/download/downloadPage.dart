import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:alpha_sample/widgets/container/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadPage extends StatefulWidget {
  static const String routeName = "/DownloadPage";

  @override
  DownloadPageState createState() => DownloadPageState();
}

class DownloadPageState extends State<DownloadPage> with AfterLayoutMixin {
  Directory _downloadsDirectory;
  String downloadedSrc;
  TargetPlatform platform;
  bool _permissionReady;
  bool _isLoading;
  ReceivePort _port = ReceivePort();

  var src = 'https://www.w3schools.com/w3css/img_lights.jpg';
  Image image;

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    // loadConfig();

    platform = Theme.of(context).platform;

    initDownloadsDirectoryState();

    WidgetsFlutterBinding.ensureInitialized();

    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
    FlutterDownloader.registerCallback(downloadCallback);
    image = Image.network(
      src,
      width: 300,
    );

    _bindBackgroundIsolate();

    _checkPermission().then((hasGranted) {
      setState(() {
        _permissionReady = hasGranted;
      });
    });
  }

  Future<void> initDownloadsDirectoryState() async {
    Directory downloadsDirectory;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
    } on PlatformException {
      print('Could not get the downloads directory');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _downloadsDirectory = downloadsDirectory;
    });
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  downLoad(var link, var savedDir) async {
    try {
      final taskId = await FlutterDownloader.enqueue(
        url: link,
        savedDir: savedDir,
        fileName: 'test.jpg',
        showNotification: true,
        // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    } catch (e) {
      debugPrint('downloadCallback error : $e');
    }
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      debugPrint('UI Isolate Callback: $data');
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      // final task = _tasks?.firstWhere((task) => task.taskId == id);
      // if (task != null) {
      //   setState(() {
      //     task.status = status;
      //     task.progress = progress;
      //   });
      // }
      debugPrint('status: $status');
      if (status == DownloadTaskStatus.complete) {
        debugPrint('_downloadsDirectory: $_downloadsDirectory');
        setState(() {
          downloadedSrc = '${_downloadsDirectory.path}/test.jpg';
        });
      }
    });
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    print(
        'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');

    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @override
  Widget build(BuildContext context) {
    FileImage imaDownload;
    try {
      if (downloadedSrc != null) {
        imaDownload = FileImage(File(downloadedSrc));
      }
    } catch (e) {
      debugPrint('error ${e}');
    }
    return Scaffold(
      appBar: ASAppBar(
        showBack: true,
        // title: _configService.config.appName,
        title: 'Download Page',
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Long Tap image to download image'),
            SizedBox(height: 20),
            image != null
                ? Builder(
                    builder: (ctx) => GestureDetector(
                      // child: Icon(
                      //   Icons.menu,
                      //   size: 35,
                      //   // color: kColorWite,
                      // ),
                      child: image,
                      onLongPress: () {
                        debugPrint('image onLongPress');
                        downLoad(src, _downloadsDirectory.path);
                      },
                      onTap: () {
                        debugPrint('image onTap');
                      },
                    ),
                  )
                : Container(),
            SizedBox(height: 20),
            Text(
              _downloadsDirectory != null
                  ? 'Downloads directory: ${_downloadsDirectory.path}\n'
                  : 'Could not get the downloads directory',
            ),
            SizedBox(height: 20),
            imaDownload != null ? Image(image: imaDownload) : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  TextStyle answerStyle = TextStyle(
    color: Colors.black,
    fontSize: 14,
  );

  TextStyle questionStyle = TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic);
}

class _TaskInfo {
  final String name;
  final String link;

  String taskId;
  int progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  _TaskInfo({this.name, this.link});
}

class _ItemHolder {
  final String name;
  final _TaskInfo task;

  _ItemHolder({this.name, this.task});
}
