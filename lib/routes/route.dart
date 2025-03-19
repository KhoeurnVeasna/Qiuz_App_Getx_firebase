
import 'package:flutter/material.dart';
import 'package:quiz_project/pages/auth_state.dart' show AuthState;
import 'package:quiz_project/pages/forgotpassword_page.dart' show ForgotpasswordPage;
import 'package:quiz_project/pages/home_page.dart' show HomePage;
import 'package:quiz_project/pages/introdutionpage/introduction.dart' show IntroductionPage;
import 'package:quiz_project/pages/login_page.dart' show LoginPage;
import 'package:quiz_project/pages/main_page.dart' show MainPage;
import 'package:quiz_project/pages/register_page.dart' show RegisterPage;

class Routes {
  static const loginPage = '/loginPage';
  static const homePage = '/homePage';
  static const authState = '/authState';
  static const introductionPage = '/introductionPage';
  static const registerPage = '/registerPage';
  static const mainPage = '/mainPage';
  static const forgotPasswordPage = '/forgotPasswordPage';

  static Route<dynamic> generateRoute (RouteSettings settings){
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(builder: (_)=> LoginPage());
      case homePage:
        return MaterialPageRoute(builder: (_)=> HomePage());
      case authState:
        return MaterialPageRoute(builder: (_)=> AuthState());
      case introductionPage:
        return MaterialPageRoute(builder: (_)=> IntroductionPage());
      case registerPage:
        return MaterialPageRoute(builder: (_)=> RegisterPage());
      case mainPage:
        return MaterialPageRoute(builder: (_)=> MainPage());
      case forgotPasswordPage:
        return MaterialPageRoute(builder: (_)=> ForgotpasswordPage());  
      default:
        return _errorRoutes(); 
    }

  }
  static Route<dynamic> _errorRoutes(){
    return MaterialPageRoute(builder: (_)=> 
    Scaffold(
      body: Center(
        child: Text('No Page to Route'),
      ),
    ));
  }
}