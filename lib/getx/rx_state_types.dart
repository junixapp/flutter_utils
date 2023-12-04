
import 'package:get/get.dart';

mixin RxStateType {
  var state = RxStatus.loading().obs;
  void setLoading() => state.value = RxStatus.loading();
  void setSuccess() => state.value = RxStatus.success();
  void setEmpty() => state.value = RxStatus.empty();
  void setLoadingMore() => state.value = RxStatus.loadingMore();
  void setError({String? message}) => state.value = RxStatus.error(message);
}
