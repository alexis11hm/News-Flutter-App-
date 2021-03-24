import 'package:flutter/material.dart';

import 'package:noticias_provider/src/pages/tabs_page.dart';
import 'package:noticias_provider/src/services/news_service.dart';
import 'package:noticias_provider/src/theme/dark_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        title: 'Material App',
        initialRoute: 'tabs',
        routes: {'tabs': (BuildContext context) => TabsPage()},
      ),
    );
  }
}
