import 'package:pagination_example/common/configs.dart';
import 'package:pagination_example/common/constans.dart';
import 'package:pagination_example/common/styles.dart';
import 'package:pagination_example/page/first_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kSAppName,
      theme: tdMain(context),
      home: FirstPage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: kLDelegates,
      supportedLocales: kLSupports,
    );
  }
}
