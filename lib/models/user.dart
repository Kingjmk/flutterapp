import 'package:meta/meta.dart';

class User {
  int id;
  String username;
  String email;
  Token token;

  User({@required this.id, @required this.username, @required this.email});

  User.fromJson(Map<String, dynamic> json) {
    this.id = json['user']['id'];
    this.username = json['user']['username'];
    this.email = json['user']['email'];
    this.token = Token.fromJson(json['token']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.token != null) {
      data['token'] = this.token.toJson();
    }

    data['user'] = {
      'id': this.id,
      'username': this.username,
      'email': this.email,
    };
    return data;
  }

  @override
  String toString() => 'User { id: $id, name: $username, email: $email}';
}

class Token {
  String accessToken;
  String refreshToken;

  Token({@required this.accessToken, @required this.refreshToken});
  Token.fromJson(Map<String, dynamic> json): accessToken = json['access'], refreshToken = json['refresh'];
  Map<String, dynamic> toJson() => {
    'access': this.accessToken,
    'refresh': this.refreshToken,
  };


  @override
  String toString() => 'Token';
}
