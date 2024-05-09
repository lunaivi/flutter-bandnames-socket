import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

//enum es para manejar los estados de server
enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

//ChangeNatifier es para refrescar la ui
class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  get serverStatus => this._serverStatus;
  SocketService() {
    this._initConfig();
  }
  void _initConfig() {
    // Dart client
    Socket socket = io(
        'http://192.168.1.8:3000',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    socket.onConnect((_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    socket.onDisconnect((_) {
      ('disconnect');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }
}
