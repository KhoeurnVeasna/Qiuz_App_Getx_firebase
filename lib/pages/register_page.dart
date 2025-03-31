import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_project/controllers/user_controller.dart';
import 'package:quiz_project/widgets/button_submit_widget.dart';
import 'package:quiz_project/widgets/widget.dart';
import '../theme/colors.dart';
import '../widgets/text_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  static double spaceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.02;
  static double spaceHeightLogin(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.05;

  final formKey = GlobalKey<FormState>(); 
  final UserController _userController =Get.find();
  

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
                height: MediaQuery.of(context).size.height * 0.9,
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
                      Text(tran.welcometoMyapp,
                          style: GoogleFonts.robotoCondensed(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: AppColor.wellcom)),
                      SizedBox(
                        height: spaceHeight(context),
                      ),
                      TextFieldWidget(
                        controller: _usernameController,
                        focusNode: _usernameFocus,
                        icon: Icon(Icons.person, color: AppColor.introBk),
                        label: tran.username,
                      ),

                      SizedBox(
                        height: spaceHeight(context),
                      ),
                      TextFieldWidget(
                          controller: _emailController,
                          focusNode: _emailFocus,
                          icon: Icon(Icons.email, color: AppColor.introBk),
                          label: tran.email),

                      SizedBox(
                        height: spaceHeight(context),
                      ),
                      TextFieldWidget(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        icon: Icon(Icons.lock, color: AppColor.introBk),
                        label: tran.password,
                        obscureText: true,
                      ),
                      // Align(
                      //     alignment: Alignment.centerRight,
                      //     child: TextButton(
                      //         onPressed: () {},
                      //         child: Text('Forgot Password?'))),
                      // Login Bottion
                      SizedBox(
                        height: spaceHeight(context),
                      ),
                      SizedBox(
                        height: 60,
                        width: 200,
                        child: ButtonSubmitWidget(
                          text: tran.register,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              bool isRegister = await _userController
                                  .sigin(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                      _usernameController.text.trim());
                              if (!context.mounted) return;
                              if (isRegister) {
                                showSnackbar(
                                    context, 'Register success', Colors.green);
                                Navigator.pushNamed(context, '/mainPage');
                              } else {
                                showSnackbar(
                                    context, 'Register failed', Colors.red);
                              }
                            }

                            if (_emailController.text.isEmpty) {
                              FocusScope.of(context).requestFocus(_emailFocus);
                            } else if (_passwordController.text.isEmpty) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocus);
                            }
                          },
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
                              tran.orrigister,
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
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[200],
                            child: IconButton(
                              onPressed: () {
                                // Handle Google Sign In
                              },
                              icon: Image.asset('assets/logos/7611770.png',
                                  height: 30),
                            ),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[200],
                            child: IconButton(
                              onPressed: () {
                                // Handle Facebook Sign In
                              },
                              icon: Image.asset('assets/logos/747.png',
                                  height: 30),
                            ),
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[200],
                            child: IconButton(
                              onPressed: () {
                                // Handle Facebook Sign In
                              },
                              icon: Image.asset(
                                  'assets/logos/Facebook_Logo_2023.png',
                                  height: 30),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: spaceHeightLogin(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tran.areYouamem),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/loginPage');
                            },
                            child: Text(tran.loginnow),
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
