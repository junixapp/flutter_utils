import 'dart:async';
import 'dart:io' as io;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fuck_utils/fuck_utils.dart';


///图片缓存
class CacheImageUtil {
  CacheImageUtil._();

  ///前提：你使用了cached_network_image来加载图片，将图片url保存到相册，返回路径
  static Future<SaveResult?> saveCacheImage2Album(String imageUrl, {String? fileName}) async {
    var file = await DefaultCacheManager().getSingleFile(imageUrl);
    if(await file.exists()){
      return await ImageUtil.saveFile2Album(file.path, fileName: fileName);
    }else{
      return null;
    }
  }

  ///前提：你使用了cached_network_image来加载图片，根据图片url返回其缓存的File对象
  static Future<io.File?> cacheImageFile(String imageUrl) async {
    var file = await DefaultCacheManager().getSingleFile(imageUrl);
    return file;
  }

  static void preloadImage(String url){
    DefaultCacheManager().downloadFile(url);
  }
}
