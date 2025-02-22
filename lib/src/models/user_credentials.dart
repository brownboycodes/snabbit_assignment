class UserCredentials {
  UserCredentials(
      {required this.username, required this.password, this.hasReferralCode});

  ///[username] of the User to login or signup
  final String username;

  ///[password]  of the User to login or signup
  final String password;

  ///[hasReferralCode] indicates if User has a referral code
  final bool? hasReferralCode;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'hasReferralCode': hasReferralCode
    };
  }

  factory UserCredentials.fromJson(Map<String, dynamic> json) {
    return UserCredentials(
        username: json['username'],
        password: json['password'],
        hasReferralCode: json['hasReferralCode']);
  }
}
