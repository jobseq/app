import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:job/Network/constants.dart';

class AuthenticatingClient extends http.BaseClient {
  AuthenticationToken? token;
  int authTime = 0;
  final String username;
  final String password;
  final http.Client _inner;
  final Authenticator authenticator;

  AuthenticatingClient(this._inner, this.authenticator, this.username, this.password);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (_authExpired()) {
      token = await authenticator.authenticate(username, password);
      authTime = DateTime.now().millisecondsSinceEpoch;
    }
    request.headers['Authorization'] = "Bearer ${token?.token}";
    return _inner.send(request);
  }

  bool _authExpired() {
    if (token == null) return true;
    return authTime + (token?.expirationSeconds ?? 0) < DateTime.now().millisecondsSinceEpoch;
  }
}

class AuthenticationToken {
  final String token;
  final int expirationSeconds;

  AuthenticationToken(this.token, this.expirationSeconds);
}

class Authenticator {
  final http.Client authClient;

  Authenticator(this.authClient);

  Future<AuthenticationToken?> authenticate(final String username, final String password) async {
    final uri = Uri.parse(baseUrl + "/authenticate");
    final response = await http.post(uri, body: json.encode({
      "uid": username,
      "password": password,
    }), headers: {
      "Accept": "application/json",
      "content-type":"application/json"
    });
    if (response.statusCode != 200) {
      return null;
    }
    final jsonBody = json.decode(response.body);
    return AuthenticationToken(jsonBody['token'], jsonBody['secondsToExpiration']);
  }
}