import 'dart:convert';
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:lunch_app/models/models.dart';

class LunchApiClient {
  static const baseUrl = 'http://10.0.15.17:3000';
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
    final menuList = menusJsonList.map((m) => Menu.fromJson(m)).toList();

    return menuList;
  }

  Future<List<Garnish>> getGarnishes() async {
    final garnishesUrl = '$baseUrl/api/garnish';
    final garnishResponse = await httpClient.get(garnishesUrl);

    if(garnishResponse.statusCode != 200) {
      throw Exception('Error getting garnishes');
    }

    final garnishesJsonList = jsonDecode(garnishResponse.body) as List;
    final garnishList = garnishesJsonList.map((g) => Garnish.fromJson(g)).toList();

    return garnishList;
  }

  Future<List<Location>> getLocations() async {
    final locationsUrl = '$baseUrl/api/location';
    final locationResponse = await httpClient.get(locationsUrl);

    if(locationResponse.statusCode != 200){
      throw Exception('Error getting locations');
    }

    final locationJsonList = jsonDecode(locationResponse.body) as List;
    final locationList = locationJsonList.map((l) => Location.fromJson(l)).toList();

    return locationList;
  }

  Future<List<Turn>> getTurns() async {
    final turnsUrl = '$baseUrl/api/turn';
    final turnResponse = await httpClient.get(turnsUrl);

    if(turnResponse.statusCode != 200){
      throw Exception('Error getting turns');
    }

    final turnsJsonList = jsonDecode(turnResponse.body) as List;
    final turnsList = turnsJsonList.map((t) => Turn.fromJson(t)).toList();

    return turnsList;
  }
}