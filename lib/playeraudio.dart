import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/hadithe.dart';

typedef void OnError(Exception exception);

void main() {
  runApp(new MaterialApp(debugShowCheckedModeBanner: false,home:  LocalAudio()));
}

class LocalAudio extends StatefulWidget {
  final Hadith hadith;
  final String localAudioPath;
  LocalAudio({this.localAudioPath, this.hadith});

  @override
  _LocalAudio createState() =>  _LocalAudio();
}

class _LocalAudio extends State<LocalAudio> {
  Duration _duration = new Duration();
  Duration _position = new Duration();

  static final AudioPlayer  advancedPlayer = new AudioPlayer();
  final AudioCache  audioCache = new AudioCache(fixedPlayer: advancedPlayer);

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {


    advancedPlayer.durationHandler = (d) => setState(() {
      onError: (Exception exception) =>
          print('_loadFile => exception $exception');
      _duration = d;
    });

    advancedPlayer.positionHandler = (p) => setState(() {
      _position = p;
    });
  }

  String localFilePath;

  Widget _tab(List<Widget> children) {
    return Column(

     mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      // Icon(Icons.add_shopping_cart,color:Colors.cyan,size: 250),
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Center(

    child:   Text(widget.hadith.key+'\n'+widget.hadith.nameHadith,



      style:  TextStyle(
        fontSize: MediaQuery.of(context).size.height * .05,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = MediaQuery.of(context).size.height *.0025
          ..color = Colors.black,

      ),

      textDirection: TextDirection.rtl,


    ),

  ),
),
         slider(),
        Container(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: children
                .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
                .toList(),
          ),
        ),
      ],
    );
  }

  //// test
  VoidCallback onPressedplypus(){
  bool bol=false;
   if(0==0){
     bol=true;
     audioCache.play("path");
     _btn(Icon(Icons.play_arrow), () => advancedPlayer.pause());
   }else{
     bol=false;
     advancedPlayer.pause();
     _btn(Icon(Icons.pause), () => advancedPlayer.pause());
   }

  }
  Widget _btn(Icon icon, VoidCallback onPressed) {
    return ButtonTheme(
      minWidth: 50.0,
      child: Container(
        width: 70,
        height: 50,
        child: RaisedButton(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: icon,
            color: Colors.black45,
            textColor: Colors.orange,
            onPressed: onPressed),
      ),
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.orange,
        inactiveColor: Colors.black45,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });
        });
  }

  Widget LocalAudio( String path) {

    return _tab([
      _btn(Icon(Icons.play_arrow), () => audioCache.play(path)),
       _btn(Icon(Icons.pause), () => advancedPlayer.pause()),
      _btn(Icon(Icons.stop), () => advancedPlayer.stop()),
    ]);
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    advancedPlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
     return      Container(

       decoration: BoxDecoration(
         // assets/ryan.jpg
         image: DecorationImage(image: AssetImage("assets/aa.jpg"), fit: BoxFit.cover),
       ),
       child:    LocalAudio(widget.localAudioPath),


     ) ;
  }

}