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

  @override
  void onInit() {
    super.onInit();
    isCountingDown.value = false;
    isCountingDown2.value = false;
    _isClosed = false;
  }

  ///倒计时
  void startCountDown() {
    if (_isClosed) return;
    isCountingDown.value = true;
    _timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(timer.tick > 60){
        isCountingDown.value = false;
        countDownTime.value = 60;
        timer.cancel();
        return;
      }
      countDownTime.value = 60 - timer.tick;
      if (countDownTime.value == 0) {
        isCountingDown.value = false;
        countDownTime.value = 60;
        timer.cancel();
        return;
      }
    });
  }

  void startCountDown2() {
    if (_isClosed) return;
    isCountingDown2.value = true;
    _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(timer.tick > 60){
        isCountingDown2.value = false;
        countDownTime2.value = 60;
        timer.cancel();
        return;
      }
      countDownTime2.value = 60 - timer.tick;
      if (countDownTime2.value == 0) {
        isCountingDown2.value = false;
        countDownTime2.value = 60;
        timer.cancel();
        return;
      }
    });
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
