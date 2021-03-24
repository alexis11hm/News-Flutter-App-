import 'package:flutter/material.dart';
import 'package:noticias_provider/src/pages/tab1_page.dart';
import 'package:noticias_provider/src/pages/tab2_page.dart';
import 'package:noticias_provider/src/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Instancia de NavigationModel que maneja el estado de la aplicacion
    final navigationModel = Provider.of<_NavigationModel>(context);
    return BottomNavigationBar(
        currentIndex: navigationModel.paginaActual,
        onTap: (i) => navigationModel.paginaActual = i,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Text('Para ti')),
          BottomNavigationBarItem(
              icon: Icon(Icons.public), title: Text('Encabezado'))
        ]);
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    return PageView(
      controller: navigationModel.pageController,
      //physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(), //Doesn't allow horizontal scroll
      children: <Widget>[Tab1Page(), Tab2Page()],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = PageController(initialPage: 0);

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeInCubic);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
