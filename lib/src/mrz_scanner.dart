import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mrz_scanner/src/camera_overlay.dart';
import 'package:flutter_mrz_scanner/src/mrz_parser/mrz_parser.dart';
import 'package:flutter_mrz_scanner/src/mrz_parser/mrz_result.dart';

/// MRZ scanner camera widget
class MRZScanner extends StatelessWidget {
  const MRZScanner({
    required this.controller,
    this.withOverlay = false,
    required this.onParsed,
    required this.onError,
    Key? key,
  }) : super(key: key);

  final MRZController controller;
  final bool withOverlay;
  final ValueChanged<MRZResult> onParsed;
  final ValueChanged<String> onError;

  void onPlatformViewCreated(int id) {
    controller.init(id, onParsed, onError);
  }

  @override
  Widget build(BuildContext context) {
    final scanner = defaultTargetPlatform == TargetPlatform.iOS
        ? UiKitView(
            viewType: 'mrzscanner',
            onPlatformViewCreated: (int id) => onPlatformViewCreated(id),
            creationParamsCodec: const StandardMessageCodec(),
          )
        : defaultTargetPlatform == TargetPlatform.android
            ? AndroidView(
                viewType: 'mrzscanner',
                onPlatformViewCreated: (int id) => onPlatformViewCreated(id),
                creationParamsCodec: const StandardMessageCodec(),
              )
            : Text('$defaultTargetPlatform is not supported by this plugin');

    return withOverlay ? CameraOverlay(child: scanner) : scanner;
  }
}

class MRZController {
  late final MethodChannel _channel;
  late final ValueChanged<MRZResult> onParsed;
  late final ValueChanged<String> onError;

  void init(
    int id,
    ValueChanged<MRZResult> onParsed,
    ValueChanged<String> onError,
  ) {
    _channel = MethodChannel('mrzscanner_$id');
    _channel.setMethodCallHandler(_platformCallHandler);
    this.onParsed = onParsed;
    this.onError = onError;
    startPreview();
  }

  void dispose() {
    stopPreview();
  }

  Future<void> _platformCallHandler(MethodCall call) {
    switch (call.method) {
      case 'onError':
        onError.call(call.arguments);
        break;
      case 'onParsed':
        final lines = _splitRecognized(call.arguments);
        if (lines.isNotEmpty) {
          final result = MRZParser.tryParse(lines);
          if (result != null) {
            onParsed(result);
          }
        }
        break;
    }
    return Future.value();
  }

  List<String> _splitRecognized(String recognizedText) {
    final mrzString = recognizedText.replaceAll(' ', '');
    return mrzString.split('\n').where((s) => s.isNotEmpty).toList();
  }

  void startPreview({bool isFrontCam = false}) => _channel.invokeMethod<void>(
        'start',
        {
          'isFrontCam': isFrontCam,
        },
      );

  void stopPreview() => _channel.invokeMethod<void>('stop');
}
