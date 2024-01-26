

import 'package:fuck_utils/fuck_utils.dart';


extension WithLoadingDialog on dynamic {
  ///给字符增加0宽字符，让文字自然换行，不跟随单词换行
  Future<T> withLoading<T>(Future<T> Function() action) async{
    try{
      DialogUtil.showLoading();
      return await action();
    }finally{
      await DialogUtil.dismissLoading();
    }
  }
}