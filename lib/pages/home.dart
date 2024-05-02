import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // lista de bands
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '1', name: 'Queen', votes: 1),
    Band(id: '1', name: 'Heroes del Silencio', votes: 2),
    Band(id: '1', name: 'Bon Jovi', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('BandsNames', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      //  listview de band//
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandTile(bands[i])),

      //////////////////////////////////////////boton flotante///////////////////////////////////////////////////////
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: Icon(Icons.add),
      ),
    );
  }

///////////////////////////////////////////////////lista de band/////////////////////////////////////////////////////////
  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction:${direction}');
        print('id${band.id}');
        print('id${band.name}');
        // TODO:llamar el borrado en el server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8),
        color: Colors.red,
        child: const Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0,
              2)), //el name.substring(0,2) es para cortal la palabra en el CicleAvactar.
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
          band.votes++;
          setState(() {});
        },
      ),
    );
  }
// metodo addNewBand

  addNewBand() {
    final textController = new TextEditingController();
    if (Platform.isAndroid) {
      //shoDialog
      //android
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('New Bands name'),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text('Add'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => addBandToList(textController.text),
            )
          ],
        ),
      );
    }

    //ios
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('New band name '),
            content: CupertinoTextField(controller: textController),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('add'),
                onPressed: () => addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Dismiss'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  void addBandToList(String name) {
    print(name);
    if (name.length > 1) {
      //podemos agragar
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
//el  Navigator.pop(context); es para cerrar la ventana de dialogo cuando terminas de escribir
    Navigator.pop(context);
  }
}
