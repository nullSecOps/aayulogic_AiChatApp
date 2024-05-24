import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gemini/components/appbar.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini/components/drawer.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatMessage> messages = [];
  final gemini = Gemini.instance;
  final ChatUser currentUser = ChatUser(
    id: "0",
    firstName: "user",
  );

  final ChatUser geminiUser = ChatUser(
      id: "1",
      firstName: "gemini",
      profileImage:
          "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiZXMCu2YtMjR9qQQ8HmTTlKwPejIyTCPs-LqwI2XExB4oQtIAMmRK4707a8VDgZsmC53c1YrPD7jqdAuyljB4kDtutWZWJs363-ODCpYuEq9JorVKbN3ZymJNkqjscFnEef7WM__cfI6Im4z5uH2W5IpPB5tZSCEpE7zTK1RlQOtKPGwcH8_8pEFxsqQ/s320/Untitled%20design.png");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black12,
      appBar: const MyAppBar(),
      drawer: const MyDrawer(),
      body: buildUI(),
    );
  }

  Widget buildUI() {
    return Container(
      child: DashChat(
          inputOptions: InputOptions(trailing: [
            IconButton(
                onPressed: () {
                  sendImage();
                },
                icon: const Icon(Icons.image))
          ]),
          currentUser: currentUser,
          onSend: sendMessage,
          messages: messages),
    );
  }

  void sendMessage(ChatMessage message) {
    setState(() {
      messages = [message, ...messages];
    });
    try {
      String questionByUser = message.text;
      List<Uint8List>? images;
      if (message.medias?.isNotEmpty ?? false) {
        images = [File(message.medias!.first.url).readAsBytesSync()];
      }
      gemini
          .streamGenerateContent(questionByUser, images: images)
          .listen((value) {
        ChatMessage? lastmessage = messages.firstOrNull;
        if (lastmessage != null && lastmessage.user == geminiUser) {
          lastmessage = messages.removeAt(0);
          String response = value.content?.parts?.fold(
                  "",
                  (previousValue, element) =>
                      "$previousValue${element.text}") ??
              "";
          lastmessage.text += response;
          setState(() {
            messages = [lastmessage!, ...messages];
          });
        } else {
          String response = value.content?.parts?.fold(
                  "",
                  (previousValue, element) =>
                      "$previousValue${element.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
          });
        }
        // print(value.output);
      });
    } catch (e) {
      // print(e.toString());
    }
  }

  void sendImage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatmessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text: "Describe this image",
          medias: [
            ChatMedia(url: file.path, fileName: "", type: MediaType.image)
          ]);
      sendMessage(chatmessage);
    }
  }
}
