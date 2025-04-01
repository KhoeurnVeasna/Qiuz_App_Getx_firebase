import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_project/controllers/user_controller.dart';
import 'package:quiz_project/pages/main_page.dart';
import 'package:quiz_project/pages/register_page.dart';
import 'package:quiz_project/services/servies_storage/service_storage.dart';
import 'package:quiz_project/theme/colors.dart';
import 'package:quiz_project/widgets/button_submit_widget.dart';
import 'package:quiz_project/widgets/text_field_widget.dart';
import '../widgets/widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations tran = AppLocalizations.of(context)!;
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
                      Text(tran.welcome,
                          style: GoogleFonts.koulen(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: AppColor.wellcom)),
                      SizedBox(
                        height: spaceHeight(context),
                      ),
                      TextFieldWidget(
                          controller: _emailController,
                          focusNode: _emailFocus,
                          label: tran.email,
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
                          label: tran.password,
                          icon: Icon(
                            Icons.lock,
                            color: AppColor.introBk,
                          )),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/forgotPasswordPage');
                              },
                              child: Text(tran.forgetPassword))),
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: ButtonSubmitWidget(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              bool isLoggedIn = await _userController.login(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                              if (!context.mounted) return;
                              if (isLoggedIn) {
                                showSnackbar(
                                    context, 'Login success', Colors.green);
                                Get.to(MainPage());
                              } else {
                                showSnackbar(
                                    context, 'Login failed', Colors.red);
                              }
                            }

                            if (_emailController.text.isEmpty) {
                              FocusScope.of(context).requestFocus(_emailFocus);
                            } else if (_passwordController.text.isEmpty) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocus);
                            }
                          },
                          text: tran.login,
                          color: AppColor.introBk2,
                        ),
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
                              tran.orLoginWith,
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
                              ('assets/logos/Facebook_Logo_2023.png'), ()async {
                                await ServiceStorage().clearIntroductionPageStatus();
                              }),
                          iconButton(AppColor.introTxt,
                              'assets/logos/7611770.png', () {
                                _userController.googleSignIn();
                              })
                        ],
                      ),
                      SizedBox(
                        height: spaceHeightLogin(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tran.areYouNewHere),
                          TextButton(
                            onPressed: () {
                              Get.to(
                                 RegisterPage(),
                              );
                            },
                            child: Text(tran.registerNow),
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
