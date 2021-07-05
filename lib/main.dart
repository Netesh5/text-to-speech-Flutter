import 'package:flutter/material.dart';

void main() {
  runApp(Texttospeech());
}

class Texttospeech extends StatelessWidget {
  const Texttospeech({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text to Speech"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
