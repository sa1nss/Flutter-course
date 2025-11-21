import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:lab4/main.dart';
import 'package:lab4/theme/theme_provider.dart';
import 'package:lab4/viewmodels/profile_viewmodel.dart';
import 'package:lab4/services/github_service.dart';
import 'package:lab4/repositories/github_repository.dart';
import 'package:lab4/viewmodels/github_viewmodel.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {

    // создаём все провайдеры как в main()
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
