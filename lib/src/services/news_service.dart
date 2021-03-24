import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticias_provider/src/models/category_model.dart';
import 'package:noticias_provider/src/models/news_models.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _API_KEY = '5ecf7d781a244c3eb3a7d4a0c5d065b6';

class NewsService with ChangeNotifier {
  final country = 'mx';
  String _selectedCategory = 'bussines';

  List<Article> headlines = [];
  List<Category> categorias = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.heart, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();
    categorias.forEach((element) {
      this.categoryArticles[element.name] = new List();
    });
  }

  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada =>
      this.categoryArticles[this.selectedCategory];

  getTopHeadlines() async {
    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=$country';
    final response = await http.get(url);
    final newsResponse = newsResponseFromJson(response.body);
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String categoria) async {
    if (this.categoryArticles[categoria].length > 0) {
      return this.categoryArticles[categoria];
    }

    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&category=$categoria';
    final response = await http.get(url);
    final newsResponse = newsResponseFromJson(response.body);
    this.categoryArticles[categoria].addAll(newsResponse.articles);
    notifyListeners();
  }
}
