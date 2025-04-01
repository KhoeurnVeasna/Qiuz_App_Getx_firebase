import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_project/controllers/user_controller.dart';
import 'package:quiz_project/pages/login_page.dart';
import 'package:quiz_project/theme/colors.dart';
import 'package:quiz_project/utils/fonts.dart';
import 'package:quiz_project/widgets/button_submit_widget.dart';

import '../services/firebase_auth/firebase_authentication.dart';
import '../widgets/text_field_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    final AppLocalizations tran = AppLocalizations.of(context)!;
    List<Map<String, dynamic>> itemsProfile = [
      {
        'icon': Icon(
          Icons.settings,
        ),
        'title': tran.setting,
      },
      {
        'icon': Icon(Icons.sync),
        'title': tran.process,
      },
      {
        'icon': Icon(Icons.emoji_events),
        'title': tran.reward,
      },
      {
        'icon': Icon(Icons.help),
        'title': tran.help,
      },
      {
        'icon': Icon(Icons.logout),
        'title': tran.loginout,
      }
    ];
    return Scaffold(
      backgroundColor: AppColor.introBk2,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.introBk2,
        centerTitle: true,
        title: Text(
          tran.profile,
          style: AppFonts.userText,
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: CircleAvatar(
                    maxRadius: 60,
                    backgroundColor: AppColor.introBk,
                    child: Text(
                      userController.username.substring(0,1).toLowerCase(),
                      style: AppFonts.userText
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    userController.username.value,
                    style: AppFonts.userText,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          final GlobalKey<FormState> formKey =
                              GlobalKey<FormState>();
                          final TextEditingController txtNewuser =
                              TextEditingController();
                          final FocusNode txtNewName = FocusNode();

                          return AlertDialog(
                            title: Center(
                              child: Text(
                                'Enter new Username',
                                style: AppFonts.titleBlue,
                              ),
                            ),
                            content: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFieldWidget(
                                    controller: txtNewuser,
                                    focusNode: txtNewName,
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ButtonSubmitWidget(onPressed: (){
                                        Get.back();
                                      },
                                      color: Colors.red,
                                      text: 'Cancal',),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ButtonSubmitWidget(
                                        onPressed: () {
                                          if (formKey.currentState!.validate()) {
                                            if (txtNewuser.text.isEmpty) {
                                              FocusScope.of(context).requestFocus(txtNewName);
                                            } else {
                                              userController.changeUsername(
                                                  txtNewuser.text.trim());
                                              Get.back();
                                              txtNewuser.clear();
                                            }
                                          }
                                        },
                                        color: Colors.green,
                                        text: 'Save',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: AppColor.introBk,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(
                        color: Color.fromARGB(171, 105, 105, 105),
                      ),
                  itemCount: itemsProfile.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: ListTile(
                        onTap: () async {
                          if (index == itemsProfile.length - 1) {
                            await FirebaseAuthentication().logout();
                            Get.offAll(LoginPage());
                          }
                        },
                        leading: itemsProfile[index]['icon'],
                        iconColor: Colors.white,
                        title: Text(
                          itemsProfile[index]['title'].toString(),
                          style: AppFonts.userText,
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
