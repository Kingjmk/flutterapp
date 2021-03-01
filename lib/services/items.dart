import 'package:app/config.dart' as config;
import 'package:app/models/models.dart';
import 'package:app/services/services.dart';

class ItemService {
  String itemUrl = '${config.baseUrl}/items'; // + /:id

  Future<List<Item>> list() async {
    var res = await ApiService.get(itemUrl);
    var itemList = res.data;
    return List<Item>.from(itemList.map((model) => Item.fromJson(model)));
  }

  Future<Item> get(int id) async {
    var res = await ApiService.get('$itemUrl/$id');
    return Item.fromJson(res.data);
  }
}
