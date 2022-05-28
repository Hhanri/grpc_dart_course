import 'package:dart_grpc_server/dart_grpc_server.dart';
import 'package:dart_grpc_server/src/generated/groceries.pb.dart';

class HelperMethods {
  Category getCategoryFromMap(Map category) {
    final idTag = 1;
    final nameTag = 2;
    int id = category['id'];
    String name = category['name'];
    return Category.fromJson('{"$idTag": $id, "$nameTag": "$name"}');
  }

  Item getItemFromMap(Map item) {
    final idTag = 1;
    final nameTag = 2;
    final categoryTag = 3;
    int id = item['id'];
    String name = item['name'];
    int categoryId = item['categoryId'];
    return Item.fromJson('{"$idTag": $id, "$nameTag": $name. "$categoryId": $categoryId}');
  }
}

final HelperMethods helper = HelperMethods();