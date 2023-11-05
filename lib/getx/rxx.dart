import 'package:fuck_utils/getx/rx_state_types.dart';
import 'package:get/get.dart';

class Rxx<T> extends Rx<T> with RxStateType{
  Rxx(T initial) : super(initial);

  @override
  void setLoading() {
    super.setLoading();
    subject.add(value);
  }

  @override
  void setSuccess() {
    super.setSuccess();
    subject.add(value);
  }

  @override
  void setEmpty() {
    super.setEmpty();
    subject.add(value);
  }
  @override
  void setError({String? message}) {
    super.setError(message:message);
    subject.add(value);
  }
}