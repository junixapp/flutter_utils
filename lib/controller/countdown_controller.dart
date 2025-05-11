import 'dart:async';
import 'package:get/get.dart';

///倒计时
class CountDownController extends GetxController {

  int totalDuration = 60;
  var isCountingDown = false.obs;
  var countDownTime = 60.obs;
  var _isClosed = false;
  Timer? _timer1;
  CountDownController({this.totalDuration = 60});

  @override
  void onInit() {
    super.onInit();
    countDownTime = totalDuration.obs;
    isCountingDown.value = false;
    _isClosed = false;
  }

  ///倒计时
  void startCountDown() {
    if (_isClosed || isCountingDown.value) return;
    reset();
    isCountingDown.value = true;
    _timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(timer.tick > totalDuration){
        isCountingDown.value = false;
        timer.cancel();
        onStop();
        return;
      }
      countDownTime.value = totalDuration - timer.tick;
      if (countDownTime.value == 0) {
        isCountingDown.value = false;
        timer.cancel();
        onStop();
        return;
      }
    });
  }

  void onStop(){

  }

  void stop(){
    if(_timer1?.isActive==true) _timer1?.cancel();
  }

  void reset(){
    countDownTime = totalDuration.obs;
    isCountingDown.value = false;
  }

  @override
  void onClose() {
    isCountingDown.value = false;
    _isClosed = true;
    _timer1?.cancel();
    super.onClose();
  }
}
