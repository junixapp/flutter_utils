import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuck_utils/fuck_utils.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class DialogUtil {
  DialogUtil._();

  static var _isShowLoading = false;
  static void showLoading({String? msg, bool dismissOnTouch = true,
        bool dismissOnBackPressed = true}) async {
    if (_isShowLoading) return;
    _isShowLoading = true;
    await showDialog(context: Get.context!,
        barrierDismissible: dismissOnTouch,
        builder: (context) => WillPopScope(
            child: Material(type: MaterialType.transparency,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).dialogBackgroundColor,
                        borderRadius: BorderRadius.circular((10.w))),
                    padding: msg != null ? EdgeInsets.symmetric(vertical: 25.w) : null,
                    width: msg != null ? 100.w : 60.w,
                    height: msg != null ? null : 60.w,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 20.w, height: 20.w, child: const CircularProgressIndicator(),),
                        if (msg != null)
                          Padding(padding: EdgeInsets.only(top: 15.w, left: 10.w, right: 10.w),
                            child: Text(msg, style: TextStyle(color: Theme.of(Get.context!).textTheme.titleLarge!.color!,
                                fontSize: 12.w), textAlign: TextAlign.center,),)
                      ],
                    ),
                  )
                ],
              ),
            ),
            onWillPop: () {
              return Future.value(dismissOnBackPressed);
            }));
    _isShowLoading = false;
  }

  static Future<void> dismissLoading({int delay = 0}) async {
    if (_isShowLoading) {
      if (delay == 0) {
        Get.back();
        _isShowLoading = false;
      } else {
        await Future.delayed(Duration(milliseconds: delay), () async {
          _isShowLoading = false;
          Get.back();
        });
      }
    }
  }

  ///显示确认信息对话框
  static Future<T?> showConfirm<T>({Widget? child, String? title, String? content,
        String? leftBtnText, String? rightBtnText, VoidCallback? onLeftTap, VoidCallback? onRightTap,
        bool showClose = true, bool dismissOnTouch = true, Color? leftBtnBg, Color? rightBtnBg,
        bool dismissOnBackPressed = true, Color? bgColor, double? radius}) async {
    Color textColor = Theme.of(Get.context!).textTheme.bodyLarge?.color ?? Colors.black87;
    Widget c = child ?? Padding(padding: EdgeInsets.only(top: 16.w, bottom: 25.w),
      child: Text(content??"", textAlign: TextAlign.center, style:
      TextStyle(color: textColor, fontSize: 14.w)),);
    return await showCenter<T>(Stack(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.w,),
          if(title!=null)Text(title, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(Get.context!).textTheme.titleLarge!.color!,
              fontSize: 16.w),),
          c,
          Divider(height: 1, color: Theme.of(Get.context!).dividerColor,),
          Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(child: SuperText(leftBtnText ?? "取消", expand: true,
                bgColor: leftBtnBg , style: TextStyle(color: textColor, fontSize: 14.w),
                height: 44.w, onTap: onLeftTap ?? ()=> Get.back())),
            Container(height: 44.w, width: 1, color: Theme.of(Get.context!).dividerColor,),
            Expanded(child: SuperText(rightBtnText ?? "确定", expand: true,
              bgColor: rightBtnBg , style: TextStyle(color: textColor, fontSize: 14.w),
              height: 44.w, onTap: onRightTap ?? ()=> Get.back(),
            ))
          ],
          )
        ],
      ),
      if (showClose)Positioned(right: 3.w,child: IconButton(onPressed: ()=> Get.back(), icon: Icon(Icons.close,
        size: 18.w,)),)
    ],),
       dismissOnBackPressed: dismissOnBackPressed, dismissOnTouch: dismissOnTouch,
        bgColor: bgColor, radius: radius);
  }

  static Future<T?> showCenter<T>(Widget child, {bool dismissOnTouch = true,
        bool dismissOnBackPressed = true, Color? bgColor, double? radius}) async {
    return await showDialog<T>(
      context: Get.context!,
      barrierDismissible: dismissOnTouch,
      builder: (context) => WillPopScope(
          child: Dialog(
            insetPadding: EdgeInsets.all(50.w),
            clipBehavior: Clip.antiAlias,
            surfaceTintColor: Colors.transparent,
            backgroundColor: bgColor ?? Theme.of(context).dialogBackgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 10.w)),
            child: child,),
          onWillPop: () {
            return Future.value(dismissOnBackPressed);
          }),
    );
  }

  ///底部弹窗
  static Future<T?> showBottom<T>(Widget child, {double? radius, Color? bgColor,
    bool enableDrag = false}) async {
    return await showModalBottomSheet<T>(
        context: Get.context!,
        backgroundColor: Colors.transparent,
        barrierColor: null,
        isScrollControlled: true, // 设置滚动控制为 true, 取消高度限制
        enableDrag: enableDrag,
        builder: (BuildContext context) {
          return BottomSheet(
              enableDrag: false,
              shadowColor: null,
              backgroundColor: Colors.transparent,
              onClosing: () {},
              builder: (BuildContext context) {
                return AnimatedContainer(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: bgColor ?? Theme.of(context).dialogBackgroundColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(radius ?? 10.w),
                        topLeft: Radius.circular(radius ?? 10.w))
                  ),
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  duration: Duration.zero,
                  child: KeyboardDismisser(child: SafeArea(child: child,)),
                );
              });
        });
  }

  //底部列表选择弹窗
  static Future<T?> showBottomList<T>(
      List<String> list,
      Function(int) onItemClick, {
        double? radius, Color? bgColor, String cancelText = "取消"
      }) async {
    return await showBottom<T>(Column(mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(constraints: BoxConstraints(maxHeight: ScreenUtil().screenHeight*0.8),
                child: ListView.separated(itemBuilder: (c,i){
                  return OnClick(Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 15.w),
                    child: Text(list[i],
                      style: TextStyle(color: Theme.of(Get.context!).textTheme.bodyMedium!.color, fontSize: 14.w),),),
                      onTap: () {
                        Navigator.of(Get.context!).pop();
                        onItemClick(i);
                      });
                }, separatorBuilder: (c,i)=>Divider(height: 1.w,),
                    padding: EdgeInsets.zero, shrinkWrap: true,
                    itemCount: list.length),),
              Container(height: 8.w, color: Theme.of(Get.context!).dividerColor.withOpacity(0.2),),
              OnClick(Container(padding: EdgeInsets.symmetric(vertical: 15.w),
                width: double.infinity, alignment: Alignment.center,
              child: Text(cancelText, style: TextStyle(color: Theme.of(Get.context!).textTheme.bodyMedium!.color,
                  fontSize: 14.w),),), onTap: (){
                  Navigator.of(Get.context!).pop();
                },)
            ],
          ), radius: radius, bgColor: bgColor);
  }
}
