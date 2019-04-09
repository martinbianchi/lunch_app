import 'package:meta/meta.dart';

import 'package:lunch_app/repositories/lunch_api_client.dart';
import 'package:lunch_app/models/models.dart';

class LunchRepository {
  final LunchApiClient lunchApiClient;

  LunchRepository({@required this.lunchApiClient})
      : assert(lunchApiClient != null);

  Future<List<Ingredients>> getIngredients() async {
    return await lunchApiClient.getIngredients();
  }

  Future<List<Menu>> getMenus() async {
    return await lunchApiClient.getMenus();
  }

  Future<List<Garnish>> getGarnishes() async {
    return await lunchApiClient.getGarnishes();
  }

  Future<List<Location>> getLocations() async {
    return await lunchApiClient.getLocations();
  }

  Future<List<Turn>> getTurns() async {
    return await lunchApiClient.getTurns();
  }
}
