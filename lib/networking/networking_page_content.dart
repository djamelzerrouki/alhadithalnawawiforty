import 'package:alnawawiforty/model/hadithe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NetworkingPageContent extends StatefulWidget {
  final Hadith hadith;
  NetworkingPageContent( {this.hadith});

  @override
  _NetworkingPageContentState createState() => _NetworkingPageContentState();
}

class _NetworkingPageContentState extends State<NetworkingPageContent> {
  Future<String> _loader;
  bool _shouldFail = false;




  // mock function to load some data or fail after some delay
  Future<String> getData(bool shouldFail) async {
    await Future<void>.delayed(Duration(seconds: 3));
    if (shouldFail) {
      throw PlatformException(code: '404');
    }
    return widget.hadith.textHadith;
  }

  void _retry() {
    // update loader
    _loader = getData(!_shouldFail);
    setState(() => _shouldFail = !_shouldFail);
  }

  @override
  void initState() {
    super.initState();
    _loader = getData(_shouldFail);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<String>(
      future: _loader,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return SliverFillRemaining(
            child: TextAndButton(
              content: 'An error occurred',
              buttonText: 'Retry',
              onPressed: _retry,
            ),
          );
        }
        if (snapshot.hasData) {
          return SliverToBoxAdapter(
            child: TextAndButton(
              content: snapshot.data,
              buttonText: 'Reload',
              onPressed: _retry,
            ),
          );
        }
        return SliverFillRemaining(
          child: Center(child: Text('No Content')),
        );
      },
    );
  }
}

class TextAndButton extends StatelessWidget {
  const TextAndButton({Key key, this.content, this.buttonText, this.onPressed})
      : super(key: key);
  final String content;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

Center(
  child: _convertHadith(context,content),
),

          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(buttonText,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(color: Colors.white)),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

Widget _getColoredHadithText(BuildContext context,String text) {
  if (text.contains('{')) {
    var preHadith = text.substring(0, text.indexOf('{'));
    var postHadith = text.substring(text.indexOf('{'));
    var Hadith = postHadith;
    var other;
    if (postHadith.contains('}')) {
      Hadith = postHadith.substring(0, postHadith.indexOf('}'));
      other = postHadith.substring(postHadith.indexOf('}'));
    }
    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(text: preHadith,style: TextStyle(color: Colors.brown, fontSize: 18)),
          TextSpan(text: Hadith, style: TextStyle(color: Colors.green, fontSize: 18)),
          TextSpan(text: other != null ? other : "",style: TextStyle(color: Colors.brown, fontSize: 18)),
        ],

      ),
      textDirection: TextDirection.rtl,

    );
  } else {
    return Text(text);
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
        ..addAll(["{${texts.first}}", "${e.substring(0,texts.first.length)}"]);
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