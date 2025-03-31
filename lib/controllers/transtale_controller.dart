import 'package:get/get_state_manager/get_state_manager.dart';

class TranstaleController extends GetxController {

  String? _locale ;

  String? get locale => _locale;

  void changeLocale(String locale) {
    _locale = locale;
    update();
  }
}