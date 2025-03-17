import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quiz_project/controllers/auth_state_controller.dart';
import 'package:quiz_project/controllers/question_controller.dart';
import 'package:quiz_project/controllers/quiz_controller.dart';
import 'package:quiz_project/controllers/user_controller.dart';
import 'package:quiz_project/routes/route.dart';
import 'package:quiz_project/services/servies_storage/service_storage.dart';
import 'firebase_options.dart';
import 'screens/auth_state.dart';
import 'screens/introdutionpage/introduction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(QuizController());
  Get.put(QuestionController());
  Get.put(AuthStateController());
  Get.put(UserController());
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isComplate = false;
  final ServiceStorage _serviceStorage = ServiceStorage();

  @override
  void initState() {
    super.initState();
    isComplateIntroduction();
  }

  void isComplateIntroduction() async {
    final bool? status = await _serviceStorage.getIntroductionPageStatus();
    setState(() {
      isComplate = status ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: Routes.generateRoute,
      home: isComplate! ? const AuthState() : const IntroductionPage(),
      
    );
  }
}
