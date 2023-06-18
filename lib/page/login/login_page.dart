import 'package:fittrix_task/bloc/bloc_provider.dart';
import 'package:fittrix_task/page/login/login_bloc.dart';
import 'package:fittrix_task/util/validator.dart';
import 'package:fittrix_task/widget/app_btn.dart';
import 'package:fittrix_task/widget/box_widget.dart';
import 'package:fittrix_task/widget/stream_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends BLoCProvider<LoginBLoC> {
  const LoginPage({Key? key, this.loginToLocation}) : super(key: key);

  final String? loginToLocation;

  @override
  Widget build(BuildContext context, LoginBLoC bloc) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: context.pop, icon: const Icon(Icons.arrow_back)),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.search,
                  validator: textEmptyValidator,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: textTheme.labelMedium?.copyWith(color: Colors.grey),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      )
                  ),
                  onFieldSubmitted: bloc.setPassword,
                ),
                const ColumnBox(12),
                StreamBuilderWidget<bool>(
                  stream: bloc.btnEnable,
                  builder: (context, enable) {
                    return AppButton(
                      onTap: enable != null && enable
                        ? () async {
                        final result = await bloc.login();
                        if (result != null) {
                          const snackBar = SnackBar(content: Text('로그인 되었습니다.'));
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          if(loginToLocation != null) {
                            // ignore: use_build_context_synchronously
                            context.go(loginToLocation!);
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        }
                      } : null,
                      child: const Text('Login')
                    );
                  }
                ),
              ],
            ),
          )
        )
    );
  }

  @override
  LoginBLoC createBLoC() => LoginBLoC();
}