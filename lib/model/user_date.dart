class UserData {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? mobile;
  final String? email;
  final String? gender;
  final List<String>? userRole;
  final String? apiToken;
  final String? profileImage;
  final String? loginType;
  final bool? isLoggedIn;

  UserData({
     this.id,
     this.firstName,
     this.lastName,
     this.mobile,
    this.email,
     this.gender,
     this.userRole,
    this.apiToken,
    this.profileImage,
    this.loginType,
    this.isLoggedIn
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      mobile: json['mobile'],
      email: json['email'],
      gender: json['gender'],
      userRole: List<String>.from(json['user_role']),
      apiToken: json['api_token'],
      profileImage: json['profile_image'],
      loginType: json['login_type'],
      isLoggedIn: json['isLoggedIn'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'mobile': mobile,
      'email': email,
      'gender': gender,
      'user_role': userRole,
      'api_token': apiToken,
      'profile_image': profileImage,
      'login_type': loginType,
      'isLoggedIn': isLoggedIn
    };
  }
}
