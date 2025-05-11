
///资源帮助类
class AssetUtil {
  AssetUtil._();

  static String imageRoot = "asset/images/";
  static String audioRoot = "asset/audios/";
  static String videoRoot = "asset/videos/";
  static String fontRoot = "asset/fonts/";
  static String animRoot = "asset/anim/";
  static String otherRoot = "asset/other/";

  static void init({
    String? imageDir,
    String? audioDir,
    String? videoDir,
    String? fontDir,
    String? animDir,
    String? otherDir,
}){
    if(imageDir!=null) imageRoot = imageDir;
    if(audioDir!=null) audioRoot = audioDir;
    if(videoDir!=null) videoRoot = videoDir;
    if(fontDir!=null) fontRoot = fontDir;
    if(animDir!=null) animRoot = animDir;
    if(otherDir!=null) otherRoot = otherDir;

    imageRoot = imageRoot.endsWith("/") ? imageRoot : "$imageRoot/";
    audioRoot = audioRoot.endsWith("/") ? audioRoot : "$audioRoot/";
    videoRoot = videoRoot.endsWith("/") ? videoRoot : "$videoRoot/";
    fontRoot = fontRoot.endsWith("/") ? fontRoot : "$fontRoot/";
    animRoot = animRoot.endsWith("/") ? animRoot : "$animRoot/";
    otherRoot = otherRoot.endsWith("/") ? otherRoot : "$otherRoot/";
  }

  ///拼接图片路径 imageName: xxx.png
  static String imagePath(String imageName) => imageRoot + imageName;

  ///拼接音频路径 audioName: xxx.mp3
  static String audioPath(String audioName) => audioRoot + audioName;

  ///拼接视频路径 videoName: xxx.mp4
  static String videoPath(String videoName) => videoRoot + videoName;

  ///拼接字体路径 fontName: xxx.ttf
  static String fontPath(String fontName) => fontRoot + fontName;

  ///拼接动画路径 animName: xxx.json
  static String animPath(String animName) => animRoot + animName;

  ///拼接其他路径 otherName: xxx.bbb
  static String otherPath(String otherName) => otherRoot + otherName;
}
