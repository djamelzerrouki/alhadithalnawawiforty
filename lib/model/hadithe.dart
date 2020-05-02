import 'package:flutter/cupertino.dart';

class Hadith{
  String key;
  String nameHadith;
  String textHadith;
  String explanationHadith;
  String translateNarrator;
  String audioHadith;

  Hadith ({this.key, this.nameHadith, this.textHadith, this.explanationHadith,this.translateNarrator,this.audioHadith});

  //To insert the data in the bd, we need to convert it into a Map
  //Para insertar los datos en la bd, necesitamos convertirlo en un Map
  Map<String, dynamic> toMap() => {
   "key":key,
  "nameHadith":nameHadith,
   "textHadith":textHadith,
   "explanationHadith":explanationHadith,
  "translateNarrator":translateNarrator,
    "audioHadith":audioHadith,
      };

  //to receive the data we need to pass it from Map to json
  //para recibir los datos necesitamos pasarlo de Map a json
  factory Hadith.fromMap(Map<String, dynamic> json) => new Hadith(

    key:json["key"],
    nameHadith:json["nameHadith"],
    textHadith:json["textHadith"],
    explanationHadith:json["explanationHadith"],
    translateNarrator:json["translateNarrator"],
      audioHadith:json["audioHadith"],
  );
}