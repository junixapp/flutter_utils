
import 'package:fuck_utils/getx/rx_state_types.dart';
import 'package:get/get.dart';

class RxxList<T> extends RxList<T> with RxStateType{

  RxxList([List<T> initial = const []]):super(initial);

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

  @override
  void refresh() {
    super.refresh();
    ///根据不同type数据，赋值对应的state，但通用性有待考察使用场景，例如：
    if(value.isEmpty) {
      setEmpty();
    }else{
      setSuccess();
    }
  }
}

