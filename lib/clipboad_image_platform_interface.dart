import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'clipboad_image_method_channel.dart';

abstract class ClipboadImagePlatform extends PlatformInterface {
  /// Constructs a ClipboadImagePlatform.
  ClipboadImagePlatform() : super(token: _token);

  static final Object _token = Object();

  static ClipboadImagePlatform _instance = MethodChannelClipboadImage();

  /// The default instance of [ClipboadImagePlatform] to use.
  ///
  /// Defaults to [MethodChannelClipboadImage].
  static ClipboadImagePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ClipboadImagePlatform] when
  /// they register themselves.
  static set instance(ClipboadImagePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Uint8List?> getImage() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
