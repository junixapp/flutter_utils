extension FuckMapExtension on Map<String, dynamic>{
  ///remove when value is null or empty string
  Map<String, dynamic> removeNull(){
    removeWhere((key, value) => value==null || (value is String && value.isEmpty));
    return this;
  }
}