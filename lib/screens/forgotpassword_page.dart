import 'package:flutter/material.dart';
import 'package:quiz_project/theme/colors.dart';
import 'package:quiz_project/widgets/button_submit_widget.dart';
import 'package:quiz_project/widgets/text_field_widget.dart';

import '../services/firebase_auth/firebase_authentication.dart';
import '../utils/fonts.dart';

class ForgotpasswordPage extends StatelessWidget {
  ForgotpasswordPage({super.key});
  final _emailController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColor.introBk,
        backgroundColor: AppColor.introBk2,
        title: Text('Forgot Password', style: AppFonts.titleFont),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          TextFieldWidget(controller: _emailController, focusNode: _emailFocus),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 60,
            width: 200,
            child: ButtonSubmitWidget(
              text: 'Submit',
              onPressed: () async {
                await FirebaseAuthentication()
                    .forgotPassword(context, _emailController.text);
              },
              color: AppColor.introBk2,
            ),
          )
        ],
      ),
    );
  }
}
