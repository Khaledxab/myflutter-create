import 'dart:io';

void main() {
  // Define the structure you want
  final directories = [
    'lib',
    'lib/models',
    'lib/views',
    'lib/views/screens',
    'lib/views/widgets',
    'lib/controllers',
    'lib/services',
    'lib/bindings',
    'lib/routes',
    'lib/utils',
    'assets',
    'assets/images',
    'assets/fonts',
    'assets/icons',
    'assets/l10n',
    'test',
  ];

  final files = {
    'lib/main.dart': _mainFileContent(),
    'lib/controllers/home_controller.dart': _homeControllerFileContent(),
    'lib/bindings/home_binding.dart': _homeBindingFileContent(),
    'lib/models/model.dart': _modelFileContent(),
    'lib/services/api_service.dart': _apiServiceFileContent(),
    'lib/views/screens/home_screen.dart': _homeScreenFileContent(),
    'lib/views/widgets/custom_widget.dart': _widgetFileContent(),
    'lib/routes/app_pages.dart': _appPagesFileContent(),
    'lib/routes/app_routes.dart': _appRoutesFileContent(),
    'lib/utils/constants.dart': _constantsFileContent(),
    'pubspec.yaml': _pubspecFileContent(),
  };

  // Create directories
  for (var dir in directories) {
    final directory = Directory(dir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      print('Created directory: $dir');
    } else {
      print('Directory already exists: $dir');
    }
  }

  // Create files
  files.forEach((path, content) {
    final file = File(path);
    if (!file.existsSync()) {
      file.writeAsStringSync(content);
      print('Created file: $path');
    } else {
      print('File already exists: $path');
    }
  });
}

// File content functions

String _mainFileContent() => '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'routes/app_pages.dart';

void main() async {
  await GetStorage.init(); // Initialize GetStorage for persistent data
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX App',
      initialRoute: AppRoutes.HOME,
      getPages: AppPages.pages,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
''';

String _homeControllerFileContent() => '''
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  var counter = 0.obs; // Reactive state variable
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    counter.value = storage.read('counter') ?? 0;
  }

  void increment() {
    counter++;
    storage.write('counter', counter.value); // Persist counter value
  }
}
''';

String _homeBindingFileContent() => '''
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
''';

String _modelFileContent() => '''
class Model {
  // Add model logic here
}
''';

String _apiServiceFileContent() => '''
import 'package:get/get.dart';

class ApiService extends GetConnect {
  // You can use GetConnect to make API requests
  Future<Response> getData() => get('https://jsonplaceholder.typicode.com/posts');
}
''';

String _homeScreenFileContent() => '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Obx(() => Text('Counter: \${controller.counter}')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
''';

String _widgetFileContent() => '''
import 'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('This is a custom widget'),
    );
  }
}
''';

String _appPagesFileContent() => '''
import 'package:get/get.dart';
import '../views/screens/home_screen.dart';
import '../bindings/home_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
''';

String _appRoutesFileContent() => '''
abstract class AppRoutes {
  static const HOME = '/home';
}
''';

String _constantsFileContent() => '''
const String appName = 'My GetX Flutter App';
const String apiBaseUrl = 'https://api.example.com';
''';

String _pubspecFileContent() => '''
name: my_flutter_app
description: A new Flutter project using GetX and GetStorage.
version: 1.0.0+1

environment:
  sdk: ">=2.17.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  get:
  get_storage:

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  assets:
    - assets/images/
    - assets/fonts/
    - assets/icons/
    - assets/l10n/
''';
