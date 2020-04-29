import 'package:alnawawiforty/model/hadithe.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import './networking_page_content.dart';
import './networking_page_header.dart';

class NetworkingPage extends StatelessWidget {

  final Hadith hadith;
  final String data;
  NetworkingPage( {this.hadith,this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: NetworkingPageHeader(
              hadith: hadith,
              minExtent: 150.0,
              maxExtent: 250.0,
            ),
          ),
          NetworkingPageContent(data: data,),
          // SliverFillRemaining(
          //   child: Center(
          //     child: Text(
          //       'No Content',
          //       style: Theme.of(context).textTheme.headline,
          //     ),
          //   ),
          // ),


        ],
      ),

    );
  }
}