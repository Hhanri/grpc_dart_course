import 'package:dart_grpc_server/dart_grpc_server.dart';
import 'package:grpc/grpc.dart';

class GroceriesService extends GroceriesServiceBase{
  @override
  Future<Category> createCategory(ServiceCall call, Category request) async {
    return categoriesServices.createCategory(request);
  }

  @override
  Future<Item> createItem(ServiceCall call, Item request) async {
    return itemsServices.createItem(request);
  }

  @override
  Future<Empty> deleteCategory(ServiceCall call, Category request) async {
    categoriesServices.deleteCategory(request);
    return Empty();
  }

  @override
  Future<Empty> deleteItem(ServiceCall call, Item request) async {
    return itemsServices.deleteItem(request);
  }

  @override
  Future<Category> editCategory(ServiceCall call, Category request) async {
    return categoriesServices.editCategory(request);
  }

  @override
  Future<Item> editItem(ServiceCall call, Item request) async {
    return itemsServices.editItem(request);
  }

  @override
  Future<Categories> getAllCategories(ServiceCall call, Empty request) async{
    return Categories()..categories.addAll(categoriesServices.getAllCategories());
  }

  @override
  Future<Items> getAllItems(ServiceCall call, Empty request) async {
    return Items()..items.addAll(itemsServices.getAllItems());
  }

  @override
  Future<Category> getCategory(ServiceCall call, Category request) async {
    return categoriesServices.getCategoryByName(request.name);
  }

  @override
  Future<Item> getItem(ServiceCall call, Item request) async {
    return itemsServices.getItemByName(request.name);
  }

  @override
  Future<AllItemsOfCategory> getItemsByCategory(ServiceCall call, Category request) async {
    return AllItemsOfCategory(
      items: itemsServices.getItemsByCategory(request.id),
      categoryId: request.id
    );
  }

}

Future<void> main() async {
  final server = Server(
    [GroceriesService()],
    const <Interceptor>[],
    CodecRegistry()
  );
  await server.shutdown();
  await server.serve(port: 50000);
  print('server listening on port ${server.port}');
}