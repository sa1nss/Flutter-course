import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'viewmodels/profile_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;

    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: MaterialApp.router(
        title: 'Резюме Білдер',
        routerConfig: router,
        theme: ThemeData(primarySwatch: Colors.indigo),
      ),
    );
  }
}
