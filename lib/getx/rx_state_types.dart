
import 'package:get/get.dart';

mixin RxStateType {
  var state = RxStatus.loading();
  void setLoading() => state = RxStatus.loading();
  void setSuccess() => state = RxStatus.success();
  void setEmpty() => state = RxStatus.empty();
  void setLoadingMore() => state = RxStatus.loadingMore();
  void setError({String? message}) => state = RxStatus.error(message);
}
