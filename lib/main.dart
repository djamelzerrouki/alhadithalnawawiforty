import 'dart:ui';

import 'package:alnawawiforty/db/mydata.dart';
import 'package:alnawawiforty/model/hadithe.dart';
 import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'botombar.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home:   Scaffold(
         appBar: AppBar(
           // Here we take the value from the MyHomePage object that was created by
           // the App.build method, and use it to set our appbar title.
           title: Center(
             child: Text("فهرس الأربعين النووية" ,
               style: TextStyle(color: Colors.white,
               fontSize: 20 ),
               textDirection: TextDirection.rtl,

             ),
           ),
           backgroundColor: Colors.brown,
         ),
         body: CollapsingList(),
      //body: NetworkingPage(),
      ),
    );
  }
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent)
  {
    return new SizedBox.expand(child: child);
  }
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
class CollapsingList extends StatelessWidget {
  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 200.0,
        child: Container(
            color: Colors.lightBlue, child: Center(child:
        Text(headerText))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<Hadith>>(

      //we call the method, which is in the folder db file database.dart
        future: Mydata.getAlldata(),
        builder: (BuildContext context, AsyncSnapshot<List<Hadith>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              //Count all records

              itemCount: snapshot.data.length,
              //all the records that are in the Operation table are passed to an item Operation item = snapshot.data [index];
              itemBuilder: (BuildContext context, int index) {
                Hadith item = snapshot.data[index];
                //delete one register for id
                return
//                  Dismissible(
//                  key: UniqueKey(),
//                  background: Container(color: Colors.red),
//                  onDismissed: (diretion) {
//
//                  },

                    Card(

                    margin: EdgeInsets.all(3.0),
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0))),
                    child: ListTile(

                      title:
                      RichText(
                        textAlign: TextAlign.right,

                        text: TextSpan(
                          style:TextStyle(fontSize:20,color: Colors.teal),
                           children: [
                            TextSpan(text: item.key+': ' , style: TextStyle(color: Colors.brown)),
                            TextSpan(text: item.nameHadith ,style: TextStyle(color: Colors.deepOrange))]
                        ),
                        textDirection: TextDirection.rtl,
                      ),

                      subtitle: Text(item.textHadith.substring(0,120) +'...', textDirection: TextDirection.rtl,),
                    trailing:Icon(Icons.library_books,color: Colors.brown,) ,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                          //HadithPage(hadith: item,)
                              HomeHadith(hadith: item,)
                        ));
                        },
                    ),
                  );
            //    );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

}