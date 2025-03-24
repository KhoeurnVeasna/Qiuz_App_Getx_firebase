import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_project/pages/main_page.dart';
import 'package:quiz_project/services/firebase_auth/firebase_authentication.dart';
import 'package:quiz_project/theme/colors.dart';
import 'package:quiz_project/widgets/button_submit_widget.dart';
import 'package:quiz_project/widgets/text_field_widget.dart';

import '../widgets/widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  static double spaceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.02;
  static double spaceHeightLogin(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.05;

  final formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.introBk2,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Hero(
                    tag: 'logoHero',
                    child: Image.asset(
                      'assets/logos/logoapp.png',
                      width: 270,
                    )),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Wellcome Back!',
                          style: GoogleFonts.robotoCondensed(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: AppColor.wellcom)),
                      SizedBox(
                        height: spaceHeight(context),
                      ),
                      TextFieldWidget(
                          controller: _emailController,
                          focusNode: _emailFocus,
                        
                          label: 'Email',
                          icon: Icon(
                            Icons.person,
                            color: AppColor.introBk,
                          )),
                      SizedBox(
                        height: spaceHeight(context),
                      ),
                      TextFieldWidget(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          obscureText: true,
                          label: 'Password',
                          icon: Icon(
                            Icons.lock,
                            color: AppColor.introBk,
                          )),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/forgotPasswordPage');
                              },
                              child: Text('Forgot Password?'))),
                      SizedBox(
                        height: 60,
                        width: 200,
                        child:ButtonSubmitWidget(onPressed: ()async{
                          if (formKey.currentState!.validate()) {
                            bool isLoggedIn =
                                await FirebaseAuthentication().login(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                            if (!context.mounted) return;
                            if (isLoggedIn) {
                              showSnackbar(
                                  context, 'Login success', Colors.green);
                              Get.to(MainPage());
                            } else {
                              showSnackbar(context, 'Login failed', Colors.red);
                            }
                          }

                          if (_emailController.text.isEmpty) {
                            FocusScope.of(context).requestFocus(_emailFocus);
                          } else if (_passwordController.text.isEmpty) {
                            FocusScope.of(context).requestFocus(_passwordFocus);
                          }
                        },text: 'Login',
                        color:AppColor.introBk2,),
                      ),
                      SizedBox(
                        height: spaceHeight(context),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'or Login with',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: spaceHeightLogin(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          iconButton(AppColor.introTxt,
                              ('assets/logos/Facebook_Logo_2023.png'), () {}),
                          iconButton(
                              AppColor.introTxt, 'assets/logos/7611770.png', () {})
                        ],
                      ),
                      SizedBox(
                        height: spaceHeightLogin(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Are you new here?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/registerPage');
                            },
                            child: Text('Register Now'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
