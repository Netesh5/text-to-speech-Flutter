import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(Texttospeech());
}

// ignore: must_be_immutable
class Texttospeech extends StatelessWidget {
  Color appbarcolor = Color(0xff1f1f1f);

  // ignore: non_constant_identifier_names
  Color primary_color = Color(0xff121212);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: appbarcolor,
        ),
        scaffoldBackgroundColor: primary_color,
      ),
    );
  }
}

// ignore: must_be_immutable
class Homepage extends StatelessWidget {
  FlutterTts flutterTts = FlutterTts();
  Color maincolor = Color(0xff1f1f1f);
  TextEditingController textEditingController = TextEditingController();
  speech(String text) async {
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text to Speech"),
        elevation: 10.0,
        leading: Icon(Icons.voice_chat_outlined),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: maincolor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          controller: textEditingController,
                          style: TextStyle(color: Colors.white),
                          cursorHeight: 30,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                )),
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: "Enter text",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: RaisedButton(
                          onPressed: () => speech(textEditingController.text),
                          child: Text(
                            "Text to speech",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blueGrey[600],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
