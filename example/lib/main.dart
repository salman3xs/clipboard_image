import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:clipboad_image/clipboad_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List? _imgData;
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getImage() async {
    Uint8List? imgData;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      imgData =
          await ClipboadImage.getImage();
    } on PlatformException {
      imgData = null;
      throw 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _imgData = imgData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: _imgData == null ? const Text('No image') : Image.memory(_imgData ?? Uint8List(0)),
            ),
            TextButton(onPressed: getImage, child: const Text('Get image'))
          ],
        ),
      ),
    );
  }
}
