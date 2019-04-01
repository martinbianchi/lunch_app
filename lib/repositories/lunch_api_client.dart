import 'dart:convert';
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:lunch_app/models/models.dart';

class LunchApiClient {
  static const baseUrl = 'http://localhost:3000';
  final http.Client httpClient;

  LunchApiClient({@required this.httpClient}) : assert (httpClient != null);

  Future<List<Ingredients>> getIngredients() async {
    final ingredientsUrl = '$baseUrl/api/ingredients/';
    final ingredientResponse = await httpClient.get(ingredientsUrl);

    if(ingredientResponse.statusCode != 200) {
      throw Exception('error getting ingrendients');
    }

    final ingredientsJsonList = jsonDecode(ingredientResponse.body) as List;
    final List<Ingredients> ingredientList = ingredientsJsonList.map((i) => Ingredients.fromJson(i)).toList();

    return ingredientList;
  }

  Future<List<Menu>> getMenus() async {
    final menusUrl = '$baseUrl/api/menu/';
    final menusResponse = await httpClient.get(menusUrl);

    if(menusResponse.statusCode != 200) {
      throw Exception('error getting menus');
    }

    final menusJsonList = jsonDecode(menusResponse.body) as List;
    final List<Menu> menuList = menusJsonList.map((m) => Menu.fromJson(m));

    return menuList;
  }
}