import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
class Env {
  @EnviedField(varName: 'AUTH_TOKEN', obfuscate: true)
  static final String authToken = _Env.authToken;
}
