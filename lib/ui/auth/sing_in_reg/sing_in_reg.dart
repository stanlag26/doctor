

import 'package:doctor/ui/auth/sing_in_reg/reg_singin_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


import '../../../api/auth/auth.dart';
import '../../../my_widgets/my_button.dart';
import '../../../my_widgets/my_text_field.dart';



class RegisterSingInProviderWidget extends StatelessWidget {
  const RegisterSingInProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RegisterSingInModel(), child: RegisterSingIn());
  }
}

class RegisterSingIn extends StatelessWidget {
  RegisterSingIn({Key? key}) : super(key: key);

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<RegisterSingInModel>();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(model.regOn == false ? 'Войти' : 'Регистрация',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                MyTextField(
                  hintTextField: 'Логин',
                  controller: _loginController, mask: false,
                ),
                MyTextField(
                  hintTextField: 'Пароль',
                  controller: _passwordController, mask: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0, top: 5),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/sign-in/forgot');
                          },
                          child: Text(
                            'Забыли пароль',
                          ))),
                ),
                model.regOn == false
                    ? MyButton(
                        myText: const Text('Войти'),
                        onPress: () async {
                          await singInError(context);
                        })
                    : MyButton(
                        myText: const Text('Регистрация'),
                        onPress: () async {
                          await registrError();
                        }),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                    onPressed: () {
                      model.tumbler();
                    },
                    child: Text(
                      model.regOn == false ? 'Регистрация' : 'Войти',
                    )),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.google,

                  ),
                  label: Text('Войти через Google аккаунт'), // <-- Text
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // всплывающее сооющение об ошибках
  Future<void> singInError(BuildContext context) async {
    var error = await MyAuth.mailSingIn(
            _loginController.text.trim(), _passwordController.text.trim()) ??
        '0';
    if (error != '0') {
      Fluttertoast.showToast(
          msg: error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> registrError() async {
    var error = await MyAuth.mailRegister(
            _loginController.text.trim(), _passwordController.text.trim()) ??
        '0';
    if (error != '0') {
      Fluttertoast.showToast(
          msg: error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _loginController.clear();
      _passwordController.clear();
    }
  }
}
