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
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

enum TtsState { playing, stopped, paused, continued }

class _HomepageState extends State<Homepage> {
  FlutterTts flutterTts = FlutterTts();

  Color maincolor = Color(0xff1f1f1f);
  dynamic languages;
  String? language;
  String? voice;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  String? newVoiceText;

  TextEditingController textEditingController = TextEditingController();
  TtsState ttsState = TtsState.stopped;
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  @override
  void initState() {
    super.initState();
    initTTs();
  }

  initTTs() {
    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });
    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });
    flutterTts.setPauseHandler(() {
      setState(() {
        ttsState = TtsState.paused;
      });
    });
    flutterTts.setContinueHandler(() {
      setState(() {
        ttsState = TtsState.continued;
      });
    });
    flutterTts.setErrorHandler((message) {
      setState(() {
        print("Error : $message");
      });
    });

    Future getLanguages() async {
      languages = await flutterTts.getLanguages;
      if (languages != null) {
        setState(() {
          return languages;
        });
      }
    }
  }

  speech(String text) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.speak(text);
  }

  stop() async {
    await flutterTts.stop();
  }

  pause() async {
    await flutterTts.pause();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterTts.stop();
  }

  List<DropdownMenuItem<String>> getLanguagesDropDownMenuItems() {
    var items = <DropdownMenuItem<String>>[];
    for (String type in languages) {
      items.add(DropdownMenuItem(value: type, child: Text(type)));
    }
    return items;
  }

  void changedLanguageDropDownItem(String? selectedType) {
    setState(() {
      language = selectedType;
      flutterTts.setLanguage(language!);
    });
  }

  void onChange(String text) {
    setState(() {
      newVoiceText = text;
    });
  }

  Widget languageDropDownSection() => Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        DropdownButton(
          value: language,
          items: getLanguagesDropDownMenuItems(),
          onChanged: changedLanguageDropDownItem,
        ),
      ]));
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
                height: MediaQuery.of(context).size.height * 0.85,
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
                      languages != null ? languageDropDownSection() : Text(""),
                      _volume(),
                      _rate(),
                      _pitch(),
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
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: RaisedButton(
                          onPressed: () => speech(textEditingController.text),
                          child: Text(
                            "Stop",
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

  Widget _volume() {
    return Slider(
        value: volume,
        onChanged: (newVolume) {
          setState(() => volume = newVolume);
        },
        min: 0.0,
        max: 1.0,
        divisions: 10,
        label: "Volume: $volume");
  }

  Widget _pitch() {
    return Slider(
      value: pitch,
      onChanged: (newPitch) {
        setState(() => pitch = newPitch);
      },
      min: 0.5,
      max: 2.0,
      divisions: 15,
      label: "Pitch: $pitch",
      activeColor: Colors.red,
    );
  }

  Widget _rate() {
    return Slider(
      value: rate,
      onChanged: (newRate) {
        setState(() => rate = newRate);
      },
      min: 0.0,
      max: 1.0,
      divisions: 10,
      label: "Rate: $rate",
      activeColor: Colors.green,
    );
  }
}
