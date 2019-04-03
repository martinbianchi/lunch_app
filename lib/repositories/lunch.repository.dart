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
}
