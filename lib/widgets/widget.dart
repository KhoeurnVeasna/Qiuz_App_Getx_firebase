import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_project/services/servies_storage/service_storage.dart';

Widget chooselangue(String language, String image, BuildContext context) {
  return SizedBox(
    height: 60,
    width: 250,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        padding: WidgetStateProperty.all(EdgeInsets.all(
          10,
        )),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35))),
      ),
      onPressed: () async{
        await ServiceStorage().saveIntroductionPageStatus(true);
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/loginPage');
        
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            maxRadius: 25,
            backgroundImage: AssetImage(image),
          ),
          SizedBox(
            width: 40,
          ),
          Text(
            language,
            style: TextStyle(
                fontFamily: GoogleFonts.koulen().fontFamily,
                fontSize: 20,
                color: Colors.blue[300]),
          ),
        ],
      ),
    ),
  );
}




void showSnackbar(BuildContext context, String text,Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: color,
    ),
  );
}
Widget iconButton(Color color, String imagePath, Function()? onPressed) {
  return CircleAvatar(
    radius: 30,
    backgroundColor: color,
    child: IconButton(
      onPressed: onPressed,
      icon: Image.asset(imagePath),
    ),
  );
}