import 'package:alnawawiforty/model/hadithe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class NetworkingPageContent extends StatefulWidget {
  final String data;
  NetworkingPageContent( {this.data});

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
    return widget.data;
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

          Center(
            child: MaterialButton(
              elevation: 5.0,
              height: 50.0,
              minWidth: 150,
              color: Colors.green,
              textColor: Colors.white,
              child: Icon(Icons.share),
              onPressed: () {
                Share.share(
                    content);
              },
            ),
          ),

//          RaisedButton(
//            color: Theme.of(context).primaryColor,
//            child: Text(buttonText,
//                style: Theme.of(context)
//                    .textTheme
//                    .headline
//                    .copyWith(color: Colors.white)),
//            onPressed: onPressed,
//          ),
        ],
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