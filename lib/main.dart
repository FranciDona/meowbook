import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

typedef void OnError(Exception exception);

void main() {
  runApp(new MaterialApp(
    theme: ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: Colors.pink,
    accentColor: Colors.white,

    // Define the default font family.
    fontFamily: 'Arial',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 24.0, fontFamily: 'Arial'),
      )
      ),
    home: new HomePage()));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Meowbook'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Entra'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookSelection()),
            );
          },
        ),
      ),
    );
  }
}

class BookSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Meowbook'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('L\'ickabog'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SceneSelection()),
            );
          },
        ),
      ),
    );
  }
}

class SceneSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Meowbook'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Capitolo 1'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MeowbookApp()),
            );
          },
        ),
      ),
    );
  }
}

class MeowbookApp extends StatefulWidget {
  @override
  _MeowbookAppState createState() => new _MeowbookAppState();
}

class _MeowbookAppState extends State<MeowbookApp> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState(){
    super.initState();
    initPlayer();
  }

  void initPlayer(){
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);

    advancedPlayer.durationHandler = (d) => setState(() {
      _duration = d;
    });

    advancedPlayer.positionHandler = (p) => setState(() {
    _position = p;
    });
  }

  String localFilePath;

  Widget _tab(List<Widget> children) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: children
              .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
              .toList(),
        ),
      ),
    );
  }

  Widget _btn(String txt, VoidCallback onPressed) {
    return ButtonTheme(
        buttonColor: Colors.pink,
        minWidth: 48.0,
        child: RaisedButton(child: Text(txt), onPressed: onPressed)
        );
  }

  Widget slider() {
    return Slider(
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });});
  }

  Widget localAsset() {
    return _tab([
      Text('C’era una volta una minuscola nazione chiamata Cornucopia, da secoli governata da una lunga stirpe di re dai capelli biondi. Ai tempi della nostra storia il re si chiamava Teo il Temerario. Il ‘Temerario’ l’aveva aggiunto lui la mattina dell’incoronazione, in parte perché stava bene con ‘Teo’, ma anche perché una volta era riuscito a catturare e uccidere una vespa tutto da solo, se non contiamo i cinque valletti e il lustrascarpe.'),
      _btn('Musica', () => audioCache.play('song2.mp3')),
      _btn('Pausa',() => advancedPlayer.pause())
    ]);
  }

  void seekToSecond(int second){
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'L\'Ickabog | Capitolo 1: Re Leo il Temerario'),
            ],
          ),
          title: Text('Welcome to Meowbook'),
        ),
        body: TabBarView(
          children: [localAsset()],
        ),
      ),
    );
  }
}