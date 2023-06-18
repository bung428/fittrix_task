import 'package:fittrix_task/bloc/bloc_provider.dart';
import 'package:fittrix_task/model/user_model.dart';
import 'package:fittrix_task/service/auth_service.dart';
import 'package:rxdart/rxdart.dart';

class LoginBLoC extends BLoC {
  String pwd = '';

  final btnEnable = BehaviorSubject<bool>()..value = false;
  Stream<bool> get btnEnableStream => btnEnable.stream;

  Future<UserModel?> login() async {
    if (pwd.isEmpty) {
      return null;
    }
    final intPwd = int.tryParse(pwd);
    if (intPwd != null) {
      return await AuthService.instance.login(intPwd);
    }
    return null;
  }

  void setPassword(String pwd) {
    if (pwd.isNotEmpty) {
      btnEnable.value = true;
    }
    this.pwd = pwd;
  }

  @override
  void dispose() {
    btnEnable.close();
  }
}