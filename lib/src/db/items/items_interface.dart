import 'package:dart_grpc_server/src/db/items/items_imp.dart';
import 'package:dart_grpc_server/src/generated/groceries.pb.dart';

abstract class InterfaceItemsServices {
  factory InterfaceItemsServices() => ItemsServices();

  Item getItemByName(String name);
  Item getItemById(int id);
  Item createItem(Item item);
  Item editItem(Item item);
  Empty deleteItem(Item item);
  List<Item> getAllItems();
  List<Item> getItemsByCategory(int categoryId);

}

final itemsServices = InterfaceItemsServices();