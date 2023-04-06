class User {
  String? address;
  String? userName;
  String? nickName;
  String? phonenumber;
  String? email;
  User(
      {this.address,
      this.userName,
      this.nickName,
      this.phonenumber,
      this.email});

  User.fromJson(Map<String, dynamic> json) {
    address = json['address'] as String?;
    userName = json['user_name'] as String?;
    nickName = json['nick_name'] as String?;
    phonenumber = json['phonenumber'] as String?;
    email = json['email'] as String?;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['user_name'] = this.userName;
    data['nick_name'] = this.nickName;
    data['phonenumber'] = this.phonenumber;
    data['email'] = this.email;
    return data;
  }

  User copyWith(
      {String? userName, String? nickName, String? address, String? email}) {
    return User(
      userName: userName ?? this.nickName,
      nickName: nickName ?? this.nickName,
      address: address ?? this.address,
      email: email ?? this.email,
    );
  }
}
