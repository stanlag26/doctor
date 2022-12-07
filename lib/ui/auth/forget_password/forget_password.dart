import 'package:flutter/material.dart';


import '../../../api/auth/auth.dart';
import '../../../my_widgets/my_button.dart';
import '../../../my_widgets/my_text_field.dart';


class ForgotWidget extends StatelessWidget {
  ForgotWidget({Key? key}) : super(key: key);
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white24,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Введите email для обнуления пароля',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            MyTextField(
              hintTextField: 'email',
              controller: _emailController,
              mask: false,
            ),
            const SizedBox(
              height: 10,
            ),
            MyButton(
              myText: Text('Обновить пароль'),
              onPress: () {
                MyAuth.resetPassword(_emailController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
