import 'package:flutter/material.dart';

import 'app.dart';
import 'injector.dart' as di;

void main() async {
  // You might not need this yet, but it's good practice to keep
  // for when you add other services that need initialization.
  WidgetsFlutterBinding.ensureInitialized();

  // Set up all your app's dependencies.
  await di.init();

  // Run your application.
  runApp(const MyApp());
}
