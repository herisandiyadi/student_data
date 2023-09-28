import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_student_app/presentation/auth/loginpage.dart';
import 'package:test_student_app/presentation/detail/detail_page.dart';
import 'package:test_student_app/presentation/home/add_page.dart';
import 'package:test_student_app/presentation/home/edit_page.dart';
import 'package:test_student_app/presentation/home/homepage.dart';

class AppRouter {
  static GoRouter routeNavigation() {
    GoRouter router = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      routerNeglect: false,
      initialLocation: '/',
      debugLogDiagnostics: true,
      errorPageBuilder: (context, state) {
        return const MaterialPage(
          child: Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
      },
      routes: [
        GoRoute(
          path: LoginPage.path,
          name: LoginPage.routeName,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
            path: Homepage.path,
            name: Homepage.routeName,
            builder: (context, state) => const Homepage(),
            routes: [
              GoRoute(
                  path: EditPage.path,
                  name: EditPage.routeName,
                  builder: (context, state) {
                    String id = state.pathParameters['id']!;
                    return EditPage(
                      id: id,
                    );
                  }),
              GoRoute(
                  path: DetailPage.path,
                  name: DetailPage.routeName,
                  builder: (context, state) {
                    String id = state.pathParameters['id']!;
                    return DetailPage(
                      id: id,
                    );
                  }),
              GoRoute(
                  path: AddPage.path,
                  name: AddPage.routeName,
                  builder: (context, state) => const AddPage()),
            ]),
      ],
    );
    return router;
  }
}
