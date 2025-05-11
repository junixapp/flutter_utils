
import 'package:example/controllers/main_controller.dart';
import 'package:example/demo_bottom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuck_utils/fuck_utils.dart';
import 'package:fuck_utils/util/dialog_util.dart';
import 'package:fuck_utils/util/log_util.dart';

class WidgetsPage extends StatelessWidget {
  const WidgetsPage({super.key});
  @override
  Widget build(BuildContext context) {
    MainController controller = Get.find();
    ToastUtil.config(dark: true);
    HttpUtil.init();
    return SingleChildScrollView(child: Wrap(
      children: [
      Obx(()=>button(context,"倒计时: [ ${ controller.isCountingDown.value ? controller.countDownTime.value
      : '未开始'}]", (){
        controller.startCountDown();
        // ToastUtil.toast("正在请求");
        // DialogUtil.showLoading();
        // HttpUtil.post("http://18.163.228.71:10001/api/v1/account/register",
        // params: {
        //   "autoLogin": true,
        //   "deviceID": "UE1A.230829.036.A1",
        //   "invitationCode": "111111",
        //   "platform": 1,
        //   "user": {
        //     "areaCode": "+86",
        //     "password": "111111",
        //     "phoneNumber": "18686868686"
        //   }
        // });
      })),
      button(context,"confirm对话框", (){
        DialogUtil.showConfirm(title: "提示", content: "确定要删除东西吗？", bgColor: Colors.amber);
      }),
      button(context,"bottomList", (){
        DialogUtil.showBottomList(['选项1','选项2', '选项3'], (i){

        });
        LogUtil.i("msg");
      }),
      button(context,"bottom自定义弹窗", (){
        DialogUtil.showBottom( DemoBottomDialog(), radius: 18.w, enableDrag: true);
      }),
      Container(padding: EdgeInsets.all(10.w),
        color: Colors.grey,
        child: Row(children: [
        Text("+86",),
        Expanded(child: WidgetUtil.textField(context, TextEditingController(), "12334",
            bgColor: Colors.red, maxLength: 10,inputFormatters:[ WidgetUtil.numberFormatter],
            inputType: TextInputType.number, fontSize: 8.w, hintFontSize: 8.w,
            fontColor: Colors.blue,bold: true)
        )
      ],),),
      CommonTabBar(tabs: ["card模式","dd", "打湿水"], onTabChange: (i){

      }, tabPadding: EdgeInsets.symmetric(horizontal: 10.w),
      tabStyle: TabStyle.card, selectBgColor: Colors.black,
        selectColor: Colors.white, unselectColor: Colors.grey,
      tabSpace: 10.w, unselectBgColor: Colors.grey.withAlpha(100),),
      CommonTabBar(tabs : ["line模式","dd", "打湿水"], onTabChange: (i){

      },  indicatorHeight: 3.w, tabEqual: true, padding: 15.w, indicatorColor: Colors.red,
      tabStyle: TabStyle.line, selectBgColor: Colors.red,
      tabSpace: 10.w, unselectBgColor: Colors.grey,),
        Obx(()=>StatusLayout(status: controller.data.state.value,
          height: 40.w,
          success: SuperText("点击加载数据" ,onTap: (){
            controller.loadData();
          },),
        ))
    ],),);
  }

  Widget button(BuildContext context, String text, VoidCallback onTap){
    return SuperText(text, onTap: onTap, borderColor: Theme.of(context).primaryColor,
      borderWidth: 1.w, radius: 20.w, padding: EdgeInsets.symmetric(horizontal: 10.w,
      vertical: 4.w),margin: EdgeInsets.all(8.w),
    );
  }
}
