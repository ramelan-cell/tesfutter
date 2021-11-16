import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tes/myhome.dart';
import 'package:tes/provider/favorite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderFavorite()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHome(),
      ),
    );
  }
}
