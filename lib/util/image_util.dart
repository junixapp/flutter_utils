import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fuck_utils/util/log_util.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

///截图
class ImageUtil {
  ImageUtil._();

  static Future<void> _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    final info = statuses[Permission.storage].toString();
    LogUtil.i(info);
  }

  ///key所在节点必须是RepaintBoundary节点，否则会报错，截取 RenderRepaintBoundary 的内容
  static Future<ByteData?> widget2image(GlobalKey key, {ImageByteFormat format = ImageByteFormat.png}) async {
    if(key.currentContext==null) return null;
    double dpr = View.of(key.currentContext!).devicePixelRatio; // 获取当前设备的像素比
    // key.currentWidget
    RenderRepaintBoundary boundary = (key).currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: dpr);
    return await (image.toByteData(format: format));
  }

  ///将widget转为图片保存到相册，返回路径
  ///key所在节点必须是RepaintBoundary节点，否则会报错，截取 RenderRepaintBoundary 的内容
  static Future<String?> saveWidget2Album(GlobalKey key, {ImageByteFormat format = ImageByteFormat.png,
    String? fileName, int quality = 80}) async {
    await _requestPermission();
    var bytes = await widget2image(key, format: format);
    if (bytes != null) {
      final result = await ImageGallerySaver.saveImage(bytes.buffer.asUint8List(),
          name: fileName,
          quality: quality,
          isReturnImagePathOfIOS: true);
      return result["filePath"] ;
    }else{
      return null;
    }
  }

  ///将图片保存到相册，返回路径
  static Future<String?> saveImage2Album(ByteData bytes, {ImageByteFormat format = ImageByteFormat.png,
    String? fileName, int quality = 80}) async {
    return await saveBytes2Album(bytes.buffer.asUint8List());
  }

  ///将图片保存到相册，返回路径
  static Future<String?> saveBytes2Album(Uint8List bytes, {ImageByteFormat format = ImageByteFormat.png,
    String? fileName, int quality = 80}) async {
    await _requestPermission();
    if (bytes != null) {
      final result = await ImageGallerySaver.saveImage(bytes,
          name: fileName,
          quality: quality,
          isReturnImagePathOfIOS: true);
      return result["filePath"] ;
    }else{
      return null;
    }
  }

}
