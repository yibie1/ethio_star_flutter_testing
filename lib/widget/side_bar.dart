import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import '../screens/home_page.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(

      color: Color.fromARGB(255, 4, 90, 161),
      height: MediaQuery.of(context).size.height * 0.87,
      padding:  const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
          children: [

            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children:  [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white,),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    )
                ],
              ),
            Row(
              children: const [
                Icon(Icons.desktop_windows, size: 50, color: Colors.white, ),
                SizedBox(width: 20,),
                Text("Dashboard", style: TextStyle(fontSize: 25, color: Colors.white),)
              ],
            ),
            const Gap(9),
            Row(
              children: const [
                Icon(Icons.settings, size: 50, color: Colors.white,),
                SizedBox(width: 20,),
                Text("Settings" , style: TextStyle(fontSize: 25, color: Colors.white),)
              ],),
              const Gap(9),
            Row(
              children: const [
                Icon(Icons.help_center_rounded, size: 50, color: Colors.white,),
                SizedBox(width: 20,),
                Text("Support" , style: TextStyle(fontSize: 25, color: Colors.white),)
              ],
            ),
            const Gap(9),
            Row(
              children: const [
                Icon(Icons.picture_as_pdf_rounded, size: 50, color: Colors.white,),
                SizedBox(width: 20,),
                Text("Automatic Reports" , style: TextStyle(fontSize: 25, color: Colors.white),)
              ],
            )
          ],
        ),
    );
  }
}
