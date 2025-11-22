import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app_router.dart';
import 'viewmodels/profile_viewmodel.dart';
import 'viewmodels/github_viewmodel.dart';
import 'repositories/github_repository.dart';
import 'services/github_service.dart';
import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await MobileAds.instance.initialize();
  }

  final profileVM = ProfileViewModel();
  await profileVM.loadProfiles();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        ChangeNotifierProvider<ProfileViewModel>.value(value: profileVM),

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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.router;
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      title: 'Резюме Білдер',
      routerConfig: router,
      themeMode: themeProvider.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}
