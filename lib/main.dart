import 'package:donation/view/home_page/front_home_page/frontpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/lanaguage_provider.dart';

void main() {
  runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: MyApp(),
    ),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      home: Frontpage()
    );
  }
}

