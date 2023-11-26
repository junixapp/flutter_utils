import 'package:dio/dio.dart';
import 'package:fuck_utils/util/object_util.dart';

class TokenInterceptor implements InterceptorsWrapper {
  String? _token;
  String tokenHeaderName;
  Function? tokenCreator;
  Function(dynamic)? onHookResponse;
  TokenInterceptor(this.tokenHeaderName, this.tokenCreator, {this.onHookResponse});

  @override
  onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (ObjectUtil.isEmpty(_token) && tokenCreator!=null) {
      _token = tokenCreator!();
    }
    if (ObjectUtil.isNotEmpty(_token)) {
      options.headers.addAll({tokenHeaderName: _token});
    }
    return handler.next(options);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    var ct = response.headers.value("content-type");
    if(ct!=null && ( ct.contains("application/json") || ct.contains("text/html"))){
      var data = response.data;
      if(onHookResponse!=null) onHookResponse!(data);
    }
    return handler.next(response);
  }
}
