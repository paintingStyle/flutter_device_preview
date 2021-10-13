import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/plugins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'basic.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  WidgetsFlutterBinding.ensureInitialized();

  _createFakeData();

  runApp(Row(
    textDirection: TextDirection.ltr,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      /*Expanded(
        child: Container(color: Colors.red),
      ),*/
      Expanded(
        child: DevicePreview(
          enabled: true,
          plugins: [
            const ScreenshotPlugin(),
            const FileExplorerPlugin(),
            const SharedPreferencesExplorerPlugin(),
          ],
          builder: (context) => BasicApp(),
        ),
      ),
    ],
  ));
}

Future<void> _createFakeData() async {
  final directory = (await getApplicationDocumentsDirectory()).path;

  final file1 = File(path.join(directory, 'example.json'));
  await file1.writeAsString('{ "example": true}');

  final directoryWithFile = Directory(path.join(directory, 'subdir'));
  await directoryWithFile.create();

  final emptyDirectory = Directory(path.join(directory, 'emptyDir'));
  await emptyDirectory.create();

  final file2 = File(path.join(directoryWithFile.path, 'example2.json'));
  await file2.writeAsString('{ "example2": true}');

  final file3 = File(path.join(directoryWithFile.path, 'example2.bin'));
  await file3.writeAsString('kjh8bhb');
}
