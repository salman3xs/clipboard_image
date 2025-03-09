import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'clipboad_image_platform_interface.dart';

/// An implementation of [ClipboadImagePlatform] that uses method channels.
class MethodChannelClipboadImage extends ClipboadImagePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('clipboad_image');

  @override
  Future<Uint8List?> getImage() async {
    final version = await methodChannel.invokeMethod<Uint8List?>('getImage');
    return version;
  }
}
