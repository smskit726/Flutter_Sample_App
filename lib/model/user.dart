class User {
  String name;
  String dept;
  String deptCd;
  String rank;
  String tel;
  String email;

  String? mobile;

  User({
    required this.name,
    required this.dept,
    required this.deptCd,
    required this.rank,
    required this.tel,
    required this.email,
    this.mobile,
  });
}
