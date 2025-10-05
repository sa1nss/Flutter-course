import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/profile_viewmodel.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();
    final profiles = vm.profiles;

    return Scaffold(
      appBar: AppBar(title: const Text('Резюме Білдер')),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return ListTile(
            title: Text(profile.title),
            subtitle: Text(profile.email),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              vm.selectProfile(profile);
              context.goNamed('about');
            },
          );
        },
      ),
    );
  }
}
