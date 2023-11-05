

import 'package:fuck_utils/getx/rxx.dart';
import 'package:fuck_utils/getx/rxx_bool.dart';
import 'package:fuck_utils/getx/rxx_list.dart';
import 'package:fuck_utils/getx/rxx_string.dart';

extension RxxStringExtension on String {
  RxxString get obx => RxxString(this);
}

extension RxxBoolExtension on bool {
  RxxBool get obx => RxxBool(this);
}

extension RxxListExtension<E> on List<E> {
  RxxList<E> get obx => RxxList<E>(this);
}

extension RxxExtension<T> on T {
  Rxx<T> get obx => Rxx<T>(this);
}
