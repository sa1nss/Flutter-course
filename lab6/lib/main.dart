import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'viewmodels/profile_viewmodel.dart';
import 'viewmodels/github_viewmodel.dart';
import 'repositories/github_repository.dart';
import 'services/github_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        Provider(create: (_) => GithubService()),
        Provider(
          create: (context) =>
              GithubRepository(service: context.read<GithubService>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              GithubViewModel(repository: context.read<GithubRepository>()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Резюме Білдер',
        routerConfig: router,
        theme: ThemeData(primarySwatch: Colors.indigo),
      ),
    );
  }
}
