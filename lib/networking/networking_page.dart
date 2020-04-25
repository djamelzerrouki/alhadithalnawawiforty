import 'package:alnawawiforty/model/hadithe.dart';
import 'package:flutter/material.dart';
import './networking_page_content.dart';
import './networking_page_header.dart';

class NetworkingPage extends StatelessWidget {
   final Hadith hadith;
  NetworkingPage( {this.hadith});

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
          NetworkingPageContent(hadith: hadith,),
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