import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_student_app/data/db/db_services.dart';
import 'package:test_student_app/data/repositories/auth_repository.dart';
import 'package:test_student_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:test_student_app/presentation/cubit/cubit/database_cubit.dart';
import 'package:test_student_app/router/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final route = AppRouter.routeNavigation();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(AuthRepositoryImpl())),
        BlocProvider(create: (context) => DatabaseCubit(DBServices())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Test Student APP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerDelegate: route.routerDelegate,
        routeInformationProvider: route.routeInformationProvider,
        routeInformationParser: route.routeInformationParser,
      ),
    );
  }
}
