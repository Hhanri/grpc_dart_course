import 'package:dart_grpc_server/dart_grpc_server.dart';

class ItemsServices implements InterfaceItemsServices{
  @override
  Item createItem(Item item) {
    items.add({'id': item.id, 'name': item.name, 'categoryId': item.categoryId});
    return item;
  }

  @override
  Empty deleteItem(Item item) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Item editItem(Item item) {
    // TODO: implement editItem
    throw UnimplementedError();
  }

  @override
  List<Item> getAllItems() {
    return items.map((item) {
      return helper.getItemFromMap(item);
    }).toList();
  }

  @override
  Item getItemById(int id) {
    var item = Item();
    final result = items.where((element) => element['id'] == id).toList();
    if (result.isNotEmpty) {
      item = helper.getItemFromMap(result.first);
    }
    return item;
  }

  @override
  Item getItemByName(String name) {
    var item = Item();
    final result = items.where((element) => element['name'] == name).toList();
    if (result.isNotEmpty) {
      item = helper.getItemFromMap(result.first);
    }
    return item;
  }

  @override
  List<Item> getItemsByCategory(int categoryId) {
    // TODO: implement getItemsByCategory
    throw UnimplementedError();
  }

}