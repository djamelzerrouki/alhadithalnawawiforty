import 'package:alnawawiforty/model/hadithe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../playeraudio.dart';


class NetworkingPageContent extends StatefulWidget {
  final String data;
  NetworkingPageContent( {this.data});

  @override
  _NetworkingPageContentState createState() => _NetworkingPageContentState();
}

class _NetworkingPageContentState extends State<NetworkingPageContent> {
  @override
  Widget build(BuildContext context) {

    return   SliverToBoxAdapter(

//      child: TextAndButton(
//        content: widget.data,
//      ),
      child:   Padding(
        padding: const EdgeInsets.only(top: 8.0,bottom: 2.0,left: 5.0,right: 8.0),
        child: Column(
          children: <Widget>[


            Center(
              child: _convertHadith(context,widget.data),
            ),
          //  LocalAudio(localAudioPath:'disco1.mp3'),


          ],
        ),
      ),
    );
  }
}

RichText _convertHadith(BuildContext context,String text) {

  text=text.replaceAll('(', '{');
  text=text.replaceAll(')', '}');

   List<String> split = text.split(RegExp("{"));

  List<String> hadiths = split.getRange(1, split.length).fold([], (t, e) {
    var texts = e.split("}");


    if (texts.length > 1) {
      return List.from(t)
        ..addAll(["{${texts.first}}", "${e.substring(texts.first.length+1)}"]);
    }
    return List.from(t)..add("{${texts.first}");
  });


return RichText(
  textAlign: TextAlign.right,

  text: TextSpan(
    style:TextStyle(fontSize:20,color: Colors.brown),
    //style: DefaultTextStyle.of(context).style,
    children: [

        TextSpan(text: split.first)]..addAll(
          hadiths.map((text) => text.contains("{")
          ? TextSpan(text: text, style: TextStyle(color: Colors.green))
          : TextSpan(text: text) )
          .toList()),

     ),
  textDirection: TextDirection.rtl,
);
}