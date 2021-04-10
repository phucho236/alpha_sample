import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

const String SOCKET_URI = "http://118.69.226.194:6688";

const List EVENTS = [
  'connect',
  'connect_error',
  'connect_timeout',
  'connecting',
  'disconnect',
  'error',
  'reconnect',
  'reconnect_attempt',
  'reconnect_failed',
  'reconnect_error',
  'reconnecting',
  'ping',
  'pong'
];

class SocketIOService {
  Future createInstance;
  IO.Socket socket;

  factory SocketIOService() => SocketIOService._internal();

  SocketIOService._internal() {
    createInstance = Future(() async {
      if (socket == null)
        socket = IO.io(SOCKET_URI, <String, dynamic>{
          'transports': ['websocket'],
        });
      checkConnectSocket();
    });
  }

  joinSocketEvent({String userId = "123"}) async {
    debugPrint('$runtimeType\n- ${socket.connected}\n- $userId');
    socket.emitWithAck(
      'join',
      userId,
      ack: (data) {
        if (data != null)
          debugPrint('From server $data');
        else
          print("Null");
      },
    );
  }

  checkConnectSocket() async {
    log('SocketIO: checkConnectSocket');
    socket.on('connect', (data) {
      joinSocketEvent();
    });
  }

  subscribeKeyEvent({Function callbackFunction}) async {
    socket.on('key_event', (data) {
      log('SocketIO: ${json.encode(data)}');
      if (callbackFunction != null) callbackFunction(data);
    });
  }

  disconnect() => socket.disconnect();
}
