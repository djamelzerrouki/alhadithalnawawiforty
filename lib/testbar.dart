import 'package:alnawawiforty/networking/networking_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'model/hadithe.dart';

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      HadithPage: HadithPage(),
//    );
//  }
//}




class HadithPage extends StatefulWidget {
  final Hadith hadith;
   HadithPage( {this.hadith});
   @override
  _HadithPageState createState() => _HadithPageState();
}

class _HadithPageState extends State<HadithPage> {
  int _selectedIndex = 0;
  bool clickedCentreFAB = false; //boolean used to handle container animation which expands from the FAB


 // List<Widget> _widgets = <Widget>[TextHadithPage(), ExplanationHadithPage(),TranslateNarratorPage()];

  PageController pageController = PageController();

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          TextHadithPage(hadith: widget.hadith,data: widget.hadith.textHadith),
          ExplanationHadithPage(hadith: widget.hadith,data: widget.hadith.explanationHadith,),
          TranslateNarratorPage(hadith: widget.hadith,data: widget.hadith.translateNarrator)
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, //specify the location of the FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Share.share(
              widget.hadith.textHadith,
              subject: widget.hadith.nameHadith);
          setState(() {
            clickedCentreFAB = !clickedCentreFAB; //to update the animated container
          });
        },
        tooltip: "Centre FAB",
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Icon(Icons.add),
        ),
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('نص الحديث'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            title: Text('شرح الحديث'),
          ),
          BottomNavigationBarItem(
             icon: Icon(Icons.transform),
            title: Text('ترجمة الراوي'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),



    );
  }
}
class TranslateNarratorPage extends StatefulWidget {
  final Hadith hadith;
  final String data;
  TranslateNarratorPage( {this.hadith,this.data});
  @override
  _TranslateNarratorPageState createState() => _TranslateNarratorPageState();
}
class _TranslateNarratorPageState extends State<TranslateNarratorPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return  NetworkingPage(hadith:widget.hadith,data:widget.hadith.translateNarrator,);

  }
}

class TextHadithPage extends StatefulWidget {
  final Hadith hadith;
  final String data;
  TextHadithPage( {this.hadith,this.data});
  @override
  _TextHadithPageState createState() => _TextHadithPageState();
}

class _TextHadithPageState extends State<TextHadithPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return  NetworkingPage(hadith:widget.hadith,data:widget.hadith.textHadith,);
  }
}

class ExplanationHadithPage extends StatefulWidget {
  final Hadith hadith;
  final String data;
  ExplanationHadithPage( {this.hadith,this.data});
  @override
  _ExplanationHadithPageState createState() => _ExplanationHadithPageState();
}

class _ExplanationHadithPageState extends State<ExplanationHadithPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
     return  NetworkingPage(hadith:widget.hadith,data:widget.hadith.explanationHadith,);

  }
}