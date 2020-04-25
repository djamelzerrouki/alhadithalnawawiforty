import 'dart:math';

import 'package:alnawawiforty/model/hadithe.dart';
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
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/item.png',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Column(
            children: <Widget>[
              Text(
                hadith.key ,
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
                ),
              ),
              Text(
                hadith.nameHadith,
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
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