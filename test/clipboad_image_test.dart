import 'package:flutter_test/flutter_test.dart';
import 'package:clipboad_image/clipboad_image.dart';
import 'package:clipboad_image/clipboad_image_platform_interface.dart';
import 'package:clipboad_image/clipboad_image_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockClipboadImagePlatform
    with MockPlatformInterfaceMixin
    implements ClipboadImagePlatform {

  @override
  Future<String?> getImage() => Future.value('42');
}

void main() {
  final ClipboadImagePlatform initialPlatform = ClipboadImagePlatform.instance;

  test('$MethodChannelClipboadImage is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelClipboadImage>());
  });

  test('getPlatformVersion', () async {
    ClipboadImage clipboadImagePlugin = ClipboadImage();
    MockClipboadImagePlatform fakePlatform = MockClipboadImagePlatform();
    ClipboadImagePlatform.instance = fakePlatform;

    expect(await clipboadImagePlugin.getPlatformVersion(), '42');
  });
}
