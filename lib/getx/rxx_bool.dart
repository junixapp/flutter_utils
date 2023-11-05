
import 'package:fuck_utils/getx/rx_state_types.dart';
import 'package:get/get.dart';

class RxxBool extends RxBool with RxStateType{
  RxxBool(super.initial);

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