extension FuckMapExtension on Map<String, dynamic>{
  Map<String, dynamic> removeNull(){
    removeWhere((key, value) => value==null);
    return this;
  }
}