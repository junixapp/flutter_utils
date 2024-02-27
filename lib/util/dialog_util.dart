import 'package:flutter/material.dart';
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
                        borderRadius: BorderRadius.circular((10))),
                    padding: msg != null ? EdgeInsets.symmetric(vertical: 25) : null,
                    width: msg != null ? 110 : 60,
                    height: msg != null ? null : 60,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 20, height: 20, child: const CircularProgressIndicator(),),
                        if (msg != null)
                          Padding(padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                            child: Text(msg, style: TextStyle(color: Theme.of(Get.context!).textTheme.titleLarge!.color!,
                                fontSize: 13), textAlign: TextAlign.center, maxLines: 1,
                                overflow: TextOverflow.ellipsis,),)
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
        bool showClose = true, bool dismissOnTouch = true, Color? leftBtnBg, Color? rightBtnBg, Color? rightBtnColor,
    Color? contentColor, bool dismissOnBackPressed = true, Color? bgColor, double? radius}) async {
    Color textColor = Theme.of(Get.context!).textTheme.bodyLarge?.color ?? Colors.black87;
    Widget c = child ?? Padding(padding: const EdgeInsets.only(top: 15, bottom: 25,
      left: 20, right: 20),
      child: Text(content??"", textAlign: TextAlign.center, style:
      TextStyle(color: textColor, fontSize: 16)),);
    return await showCenter<T>(Stack(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15,),
          if(title!=null)Text(title, textAlign: TextAlign.center, style: TextStyle(color:contentColor?? Theme.of(Get.context!).textTheme.titleLarge!.color!,
              fontSize: 18, fontWeight: FontWeight.w600),),
          c,
          const Divider(height: 1, color: Color(0x11000000),),
          Row(mainAxisSize: MainAxisSize.max, children: [
            Expanded(child: SuperText(leftBtnText ?? "取消", expand: true,
                bgColor: leftBtnBg , style: TextStyle(color: textColor.withOpacity(0.6), fontSize: 16),
                height: 50, onTap: onLeftTap ?? ()=> Get.back(result: false))),
            Container(height: 50, width: 1, color: Theme.of(Get.context!).dividerColor,),
            Expanded(child: SuperText(rightBtnText ?? "确定", expand: true,
              bgColor: rightBtnBg , style: TextStyle(color: rightBtnColor ?? textColor, fontSize: 16),
              height: 50, onTap: onRightTap ?? ()=> Get.back(result: true),
            ))
          ],
          )
        ],
      ),
      if (showClose)Positioned(right: 3,child: IconButton(onPressed: ()=> Get.back(), icon: const Icon(Icons.close,
        size: 24,)),)
    ],),
       dismissOnBackPressed: dismissOnBackPressed, dismissOnTouch: dismissOnTouch,
        bgColor: bgColor, radius: radius, padding: EdgeInsets.all(50));
  }

  static Future<T?> showCenter<T>(Widget child, {bool dismissOnTouch = true,
        bool dismissOnBackPressed = true, Color? bgColor, double? radius,
        EdgeInsets? padding}) async {
    return await showDialog<T>(
      context: Get.context!,
      barrierDismissible: dismissOnTouch,
      builder: (context) => WillPopScope(
          child: Dialog(
            insetPadding: padding,
            clipBehavior: Clip.antiAlias,
            surfaceTintColor: Colors.transparent,
            backgroundColor: bgColor ?? Theme.of(context).dialogBackgroundColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? 10)),
            child: child,),
          onWillPop: () {
            return Future.value(dismissOnBackPressed);
          }),
    );
  }

  ///底部弹窗
  static Future<T?> showBottom<T>(Widget child, {double? radius, Color? bgColor,
    bool enableDrag = true, bool dismissOnTouch = true,}) async {
    return await showModalBottomSheet<T>(
        context: Get.context!,
        backgroundColor: Colors.transparent,
        isDismissible: dismissOnTouch,
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
                    borderRadius: BorderRadius.only(topRight: Radius.circular(radius ?? 10),
                        topLeft: Radius.circular(radius ?? 10))
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
        double? radius, Color? bgColor, String cancelText = "取消",
        NullableIndexedWidgetBuilder? builder,
      }) async {
    return await showBottom<T>(Column(mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(constraints: BoxConstraints(maxHeight: Get.height*0.8),
                child: ListView.separated(itemBuilder: (c,i){
                  return OnClick( builder!=null ? builder.call(c,i)! : Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(list[i],
                      style: TextStyle(color: Theme.of(Get.context!).textTheme.bodyMedium!.color, fontSize: 14),),),
                      onTap: () {
                        Navigator.of(Get.context!).pop();
                        onItemClick(i);
                      });
                }, separatorBuilder: (c,i)=>Divider(height: 1,),
                    padding: EdgeInsets.zero, shrinkWrap: true,
                    itemCount: list.length),),
              Container(height: 8, color: Theme.of(Get.context!).dividerColor.withOpacity(0.2),),
              OnClick(Container(padding: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity, alignment: Alignment.center,
              child: Text(cancelText, style: TextStyle(color: Theme.of(Get.context!).textTheme.bodyMedium!.color,
                  fontSize: 14),),), onTap: (){
                  Navigator.of(Get.context!).pop();
                },)
            ],
          ), radius: radius, bgColor: bgColor);
  }

  static  Widget popupMenu <T>(BuildContext context, List<T> items,
      PopupMenuItemSelected<T> onSelect, Widget child, IndexedWidgetBuilder itemBuilder, {double? offsetY,
        double? height, double? itemWidth, EdgeInsets? padding, PopupMenuPosition? position,
        Color? bgColor} ){
    return PopupMenuButton<T>(
      position: position ?? PopupMenuPosition.under,
      constraints: BoxConstraints(
        minWidth: itemWidth ?? 120,
        maxWidth: itemWidth ?? 120,
      ),
      padding: EdgeInsets.zero,
      surfaceTintColor: bgColor ?? Theme.of(context).dialogBackgroundColor,
      shadowColor: bgColor ?? Theme.of(context).dialogBackgroundColor,
      offset: Offset(0, offsetY??0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: bgColor ?? Theme.of(context).dialogBackgroundColor,
      onSelected: onSelect,
      itemBuilder: (builder) => items.map((e) => PopupMenuItem<T>(
        padding: EdgeInsets.zero,
        height: height ?? 36,
        value: e!,
        child: itemBuilder(context, items.indexOf(e)),
      )).toList() ,child: child,);
  }
}
