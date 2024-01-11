class Auth {
  String? clientId;
  String? clientSecret;
  String? grantType;
  String? username;
  String? password;

  Auth({
    this.clientId,
    this.clientSecret,
    this.grantType,
    this.username,
    this.password,
  });

  Auth.fromJson(Map<String, dynamic> json) {
    clientId = json['client_id'];
    clientSecret = json['client_secret'];
    grantType = json['grant_type'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['client_id'] = clientId;
    data['client_secret'] = clientSecret;
    data['grant_type'] = grantType;
    data['username'] = username;
    data['password'] = password;
    return data;
  }

  Auth copyWith({
    String? clientId,
    String? clientSecret,
    String? grantType,
    String? username,
    String? password,
  }) {
    return Auth(
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
      grantType: grantType ?? this.grantType,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
