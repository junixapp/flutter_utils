import 'dart:async';
import 'package:get/get.dart';

///倒计时，支持2个倒计时
class CountDownController extends GetxController {
  var isCountingDown = false.obs;
  var isCountingDown2 = false.obs;
  var countDownTime = 60.obs;
  var countDownTime2 = 60.obs;
  var _isClosed = false;
  Timer? _timer1;
  Timer? _timer2;

  int totalDuration() => 60;

  @override
  void onInit() {
    super.onInit();
    countDownTime = totalDuration().obs;
    countDownTime2 = totalDuration().obs;
    isCountingDown.value = false;
    isCountingDown2.value = false;
    _isClosed = false;
  }

  ///倒计时
  void startCountDown() {
    if (_isClosed || isCountingDown.value) return;
    isCountingDown.value = true;
    _timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(timer.tick > totalDuration()){
        isCountingDown.value = false;
        timer.cancel();
        onStop();
        return;
      }
      countDownTime.value = totalDuration() - timer.tick;
      if (countDownTime.value == 0) {
        isCountingDown.value = false;
        timer.cancel();
        onStop();
        return;
      }
    });
  }

  void startCountDown2() {
    if (_isClosed || isCountingDown2.value) return;
    isCountingDown2.value = true;
    _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(timer.tick > totalDuration()){
        isCountingDown2.value = false;
        timer.cancel();
        onStop();
        return;
      }
      countDownTime2.value = totalDuration() - timer.tick;
      if (countDownTime2.value == 0) {
        isCountingDown2.value = false;
        timer.cancel();
        onStop();
        return;
      }
    });
  }

  void stopCount1(){
    if(_timer1?.isActive==true) _timer1?.cancel();
  }
  void stopCount2(){
    if(_timer2?.isActive==true) _timer2?.cancel();
  }

  void reset(){
    countDownTime = totalDuration().obs;
    isCountingDown.value = false;

    countDownTime2 = totalDuration().obs;
    isCountingDown2.value = false;
  }

  void onStop(){

  }

  @override
  void onClose() {
    isCountingDown.value = false;
    isCountingDown2.value = false;
    _isClosed = true;
    _timer1?.cancel();
    _timer2?.cancel();
    super.onClose();
  }
}
