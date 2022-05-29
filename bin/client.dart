import 'dart:io';
import 'dart:math';
import 'package:dart_grpc_server/dart_grpc_server.dart';
import 'package:grpc/grpc.dart';

class Client {
  ClientChannel? channel;
  GroceriesServiceClient? stub;
  var response;
  bool executionInProgress = true;

  Future<void> main() async {
    channel = ClientChannel(
      'localhost',
      port: 50000,
      options: ChannelOptions(credentials: ChannelCredentials.insecure())
    );

    stub = GroceriesServiceClient(
      channel!,
      options: CallOptions(timeout: Duration(seconds: 30))
    );

    final actions = [
      'View all products',
      'Add new product',
      'Edit product',
      'Get product',
      'Delete product\n',
      'View all categories',
      'Add new category',
      'Edit category',
      'Get category',
      'Delete category\n',
      'Get all products of a given category'
    ];

    String getNameInput(String type) {
      print('Enter $type name:');
      final name = stdin.readLineSync()!;
      return name;
    }

    while (executionInProgress) {
      try {
        print('----- Welcome to the Dart store API -----');
        print('  --- What do you want to do ? ---   ');
        actions.asMap().forEach((index, value) {
          print('${index + 1}: $value');
        });
        final option = int.parse(stdin.readLineSync()!);

        switch (option) {
          case 1: break;
          
          case 2:
            final name = getNameInput('item');
            final item = await _findItemByName(name);
            if (item.id != 0) {
              print('Item already exists: name ${item.name} (id: ${item.id})');
            } else {
              final categoryName = getNameInput('category');
              final category = await _findCategoryByName(categoryName);
              if (category.id == 0) {
                print("category $name doesn't exist");
              } else {
                final newItem = Item(name: name, id: _randomId(), categoryId: category.id);
                response = await stub!.createItem(newItem);
                print('Item created | name: ${item.name} (id: ${item.id})');
              }
            }
            break;

          case 3: break;
          case 4: break;
          case 5: break;

          case 6:
            response = await stub!.getAllCategories(Empty());
            print('  --- Store product Categories ---  ');
            response.categories.forEach((category) {
              print(' - name: ${category.name}, id: ${category.id}');
            });
            break;

          case 7:
            final name = getNameInput('category');
            final category = await _findCategoryByName(name.toLowerCase());
            if (category.id != 0) {
              print('Category already exists: name ${category.name} (id: ${category.id})');
            } else {
              final category = Category(
                id: Random(999).nextInt(9999),
                name: name
              );
              response = await stub!.createCategory(category);
              print('category created}| name: ${category.name} (id: ${category.id})');
            }
            break;

          case 8:
            final name = getNameInput('category');
            final category = await _findCategoryByName(name.toLowerCase());
            if (category.id != 0) {
              print('Please enter new category name');
              final newName = stdin.readLineSync()!;
              if (newName != name) {
                response = await stub!.editCategory(Category(id: category.id, name: newName));
                print('Category successfully updated | name: ${response.name} | id: ${response.id}');
              } else {
                print('The new provided name is the same as the old one, no changes done');
              }
            } else {
              print("category $name doesn't exist");
            }
            break;

          case 9:
            final name = getNameInput('category');
            final category = await _findCategoryByName(name.toLowerCase());
            if (category.id != 0) {
              print('category found | name: ${category.name} | id: ${category.id}');
            } else {
              print('no category found | no category matches with the name $name');
            }
            break;

          case 10:
            final name = getNameInput('category');
            final category = await _findCategoryByName(name.toLowerCase());
            if (category.id != 0) {
              await stub!.deleteCategory(category);
              print('category $name successfully deleted');
            } else {
              print('no category found | no category matches with the name $name');
            }
            break;
          case 11: break;
          default: print('invalid option');
        }

      } catch(e) {
        print(e);
      }

      print('Do you want to exit the store ? (Y/N)');
      final result = stdin.readLineSync() ?? 'y';
      executionInProgress = result.toLowerCase() != 'y';
    }

    await channel!.shutdown();
  }

  Future<Category> _findCategoryByName(String name) async {
    final category = await stub!.getCategory(Category(name: name));
    return category;
  }

  Future<Item> _findItemByName(String name) async {
    final item = await stub!.getItem(Item(name: name));
    return item;
  }

  int _randomId() => Random(1000).nextInt(9999);

}

void main() {
  final client = Client();
  client.main();
}