import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shake_app/providers/cart_providers.dart';
import 'package:shake_app/providers/home_provider.dart';
import 'package:shake_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context) => HomeProvider(),),
        ChangeNotifierProvider(create:(context) => CartProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shake',
        home: const HomeScreen(),
      ),
    );
  }
}

