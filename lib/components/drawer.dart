import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZXMCu2YtMjR9qQQ8HmTTlKwPejIyTCPs-LqwI2XExB4oQtIAMmRK4707a8VDgZsmC53c1YrPD7jqdAuyljB4kDtutWZWJs363-ODCpYuEq9JorVKbN3ZymJNkqjscFnEef7WM__cfI6Im4z5uH2W5IpPB5tZSCEpE7zTK1RlQOtKPGwcH8_8pEFxsqQ/s320/Untitled%20design.png'),
                    // child: Text("lkdfl"),
                  ),
                  Text(
                    "Gemini AI",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.facebook,
                  color: Colors.blueAccent,
                ),
                Icon(
                  FontAwesomeIcons.twitter,
                  color: Colors.blue,
                ),
                Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.pink,
                ),
                Icon(
                  FontAwesomeIcons.youtube,
                  color: Colors.red,
                )
                // Icon(Icons.instagram)
              ],
            )
          ],
        ),
      ),
    );
  }
}
