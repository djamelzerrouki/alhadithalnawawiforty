import 'dart:math';

import 'package:alnawawiforty/model/hadithe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NetworkingPageHeader implements SliverPersistentHeaderDelegate {
  final Hadith hadith;
  final double minExtent;
  final double maxExtent;


  NetworkingPageHeader({this.hadith,
    this.minExtent,
    @required this.maxExtent,
  });


  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [

        Container(
          height: size.height * .4,
          decoration: BoxDecoration(
            image:   DecorationImage(
           image:   AssetImage('assets/item.png', ),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
         borderRadius: BorderRadius.only(
           bottomLeft: Radius.circular(50),
           bottomRight: Radius.circular(50)
         )
          ),

        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          top: 64.0,
          child: Column(
            children: <Widget>[

              Text(
                hadith.key ,
                style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  color: Colors.white,
                ),
              ),
              Text(
                hadith.nameHadith,
                style: TextStyle(fontWeight: FontWeight.bold,
 decorationColor: Colors.black,
                   fontSize: 32.0,
                   color: Colors.white,
                ),
              ),

            ],
          ),

        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
