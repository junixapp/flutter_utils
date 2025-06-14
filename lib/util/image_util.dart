import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fuck_utils/fuck_utils.dart';
import 'package:image_gallery_saver2/image_gallery_saver.dart';

class SaveResult{
  String? path;
  bool permissionDenied;
  SaveResult({this.path, this.permissionDenied = false});
}

///截图
class ImageUtil {
  ImageUtil._();

  static Future<bool> openAppPermissionSettings(){
    return openAppSettings();
  }

  static Future<PermissionStatus> _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    // statuses.forEach((key, value) {
    //   LogUtil.i("_requestPermission: ${key.value} => ${value}");
    // });
    // if(statuses.values.firstWhereOrNull((e) => e==PermissionStatus.denied
    //     || e==PermissionStatus.permanentlyDenied)!=null){
    //   await openAppSettings();
    //   LogUtil.i("_requestPermission: openAppSettings");
    // }
    return statuses.values.first;
  }

  ///key所在节点必须是RepaintBoundary节点，否则会报错，截取 RenderRepaintBoundary 的内容
  static Future<ByteData?> widget2image(GlobalKey key, {ImageByteFormat format = ImageByteFormat.png}) async {
    if(key.currentContext==null) return null;
    double dpr = View.of(key.currentContext!).devicePixelRatio; // 获取当前设备的像素比
    RenderRepaintBoundary boundary = (key).currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: dpr);
    return await (image.toByteData(format: format));
  }

  ///将widget转为图片保存到相册，返回路径
  ///key所在节点必须是RepaintBoundary节点，否则会报错，截取 RenderRepaintBoundary 的内容
  static Future<SaveResult?> saveWidget2Album(GlobalKey key, {ImageByteFormat format = ImageByteFormat.png,
    String? fileName, int quality = 80}) async {
    var bytes = await widget2image(key, format: format);
    if (bytes != null) {
      return await saveBytes2Album(bytes.buffer.asUint8List(), format: format, fileName: fileName, quality: quality);
      // final result = await ImageGallerySaver.saveImage(bytes.buffer.asUint8List(),
      //     name: fileName,
      //     quality: quality,
      //     isReturnImagePathOfIOS: true);
      // return result["filePath"] ;
    }else{
      return null;
    }
  }

  ///将图片保存到相册，返回路径
  static Future<SaveResult?> saveImage2Album(ByteData bytes, {ImageByteFormat format = ImageByteFormat.png,
    String? fileName, int quality = 80}) async {
    return await saveBytes2Album(bytes.buffer.asUint8List());
  }

  ///将图片保存到相册，返回路径
  static Future<SaveResult?> saveBytes2Album(Uint8List bytes, {ImageByteFormat format = ImageByteFormat.png,
    String? fileName, int quality = 80}) async {

    var permResult = await _requestPermission();
    if(permResult.isGranted || permResult.isLimited){
      final result = await ImageGallerySaver.saveImage(bytes,
          name: fileName,
          quality: quality,
          isReturnImagePathOfIOS: true);
      return SaveResult(path: result["filePath"]);
    }
    return SaveResult(permissionDenied: true);
  }

  ///将图片文件保存到相册，返回路径
  static Future<SaveResult?> saveFile2Album(String filePath, {String? fileName,}) async {
    var permResult = await _requestPermission();
    if(permResult.isGranted || permResult.isLimited){
      final result = await ImageGallerySaver.saveFile(filePath,
          name: fileName, isReturnPathOfIOS: true);
      return SaveResult(path: result["filePath"],);
    }
    return SaveResult(permissionDenied: true);
  }

}
