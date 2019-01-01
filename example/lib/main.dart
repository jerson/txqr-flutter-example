import 'dart:convert';

import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter/material.dart';
import 'package:txqr/txqr.dart';

main() => runApp(Camera());

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => new _CameraState();
}

class _CameraState extends State<Camera> {
  QRReaderController controller;
  List<CameraDescription> cameras;
  String output = 'waiting...';
  String message = '';

  @override
  void initState() {
    super.initState();

    load();
  }

  Future<Null> reset() async {
    setState(() {
      output = 'waiting...';
      message = '';
    });
    await Txqr.reset();
    controller.startScanning();
  }

  void load() async {
    cameras = await availableCameras();

    controller = new QRReaderController(
        cameras[0], ResolutionPreset.medium, [CodeFormat.qr],
        (dynamic value) async {
      if (await Txqr.isCompleted()) {
        var decoded = base64.decode(await Txqr.data());
        var _output = new String.fromCharCodes(decoded);
        var _message =
            'Read in ${await Txqr.totalSize()}  in ${await Txqr.totalTime()} Speed ${await Txqr.speed()}';

        setState(() {
          output = _output;
          message = _message;
        });
        print("final data");
        print(_output);
        return;
      }
      await Txqr.decode(value);
      var _message =
          '${await Txqr.progress()}% [${await Txqr.speed()}] (${await Txqr.readInterval()}ms)';

      setState(() {
        message = _message;
      });

      controller.startScanning();
    });
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      controller.startScanning();
    });
    await Txqr.newDecoder();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return Container();
    }
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('TXQR Example'),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                Flexible(child: QRReaderPreview(controller)),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Result: ${output}"),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(message),
                ),
                Container(
                  child: RaisedButton(
                      onPressed: () async {
                        await this.reset();
                      },
                      child: Text('Reset')),
                )
              ],
            ),
          )),
    );
  }
}
