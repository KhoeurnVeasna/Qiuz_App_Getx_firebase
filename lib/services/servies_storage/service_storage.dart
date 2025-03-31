import 'package:get_storage/get_storage.dart';

class ServiceStorage {
  final _getStorage = GetStorage();
  Future<void> saveIntroductionPageStatus(bool status,) async {
    await _getStorage.write('introductionPageStatus', status);
  
  }

  Future<bool?> getIntroductionPageStatus() async {
    return await _getStorage.read('introductionPageStatus')??false;
  }
  Future<void> clearIntroductionPageStatus() async {
    await _getStorage.remove('introductionPageStatus');
    await _getStorage.remove('selectedLanguage');
  }
  Future<void> saveSelectedLanguage(String language) async {
    await _getStorage.write('selectedLanguage', language);
  }
  String getSelectedLanguage()  {
    return  _getStorage.read('selectedLanguage') ?? 'en';
  }
}
