class NhanVien{
  var hoTen;
  var age;

  NhanVien({this.hoTen, this.age});
@override
  String toString() {
    // TODO: implement toString
    return this.hoTen + ' ${this.age}';
  }
}