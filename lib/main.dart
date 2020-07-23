import 'package:flutter/material.dart';
import 'package:imdb_simple_search/Provider/searchProvider.dart';
import 'package:imdb_simple_search/Screens/search.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMDB Simple Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.white),
      home: ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
          builder: (context, child) => Search()),
    );
  }
}
