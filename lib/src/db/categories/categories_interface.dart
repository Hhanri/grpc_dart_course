import 'package:dart_grpc_server/dart_grpc_server.dart';

abstract class InterfaceCategoriesServices {
  factory InterfaceCategoriesServices() => CategoriesServices();

  Category getCategoryByName(String name);
  Category getCategoryById(int id);
  Category createCategory(Category category);
  Category editCategory(Category category);
  Empty deleteCategory(Category category);
  List<Category> getAllCategories();
}

final categoriesServices = InterfaceCategoriesServices();