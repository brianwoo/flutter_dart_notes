import 'package:flutter/material.dart';
import 'package:flutter_initial_project/ui/home/pages/my_home_page.dart';
import 'package:flutter_initial_project/ui/products/pages/products_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(title: "Flutter Demo Home Page");
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'products',
          builder: (BuildContext context, GoRouterState state) {
            return const ProductsPage();
          },
        ),
      ],
    ),
  ],
);
