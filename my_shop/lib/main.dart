import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/index.dart';
import './providers/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.ROUTE_NAME: (ctx) => ProductDetailScreen(),
          CartScreen.ROUTE_NAME: (ctx) => CartScreen(),
          OrdersScreen.ROUTE_NAME: (ctx) => OrdersScreen(),
          UserProductsScreen.ROUTE_NAME: (ctx) => UserProductsScreen(),
          ProductFormScreen.ROUTE_NAME: (ctx) => ProductFormScreen(),
        },
      ),
    );
  }
}
