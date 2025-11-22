import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/profile_viewmodel.dart';
import 'package:go_router/go_router.dart';
import '../theme/theme_provider.dart';
import '../widgets/ad_unified_banner.dart'; 
import '../views/add_profile_view.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfileViewModel>().loadProfiles();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();
    final profiles = vm.profiles;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Резюме Білдер'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, theme, _) {
              return Switch(
                value: theme.isDark,
                onChanged: (_) => theme.toggleTheme(),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProfileView()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: ListView(
        children: [
          if (profiles.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("Немає збережених резюме"),
              ),
            )
          else
            ...profiles.map(
              (profile) => Card(
                child: ListTile(
                  title: Text(profile.title),
                  subtitle: Text(profile.email),
                  leading: const Icon(Icons.person_outline),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'open') {
                        vm.selectProfile(profile);
                        context.goNamed('about');
                      } else if (value == 'duplicate') {
                        vm.duplicateProfile(profile);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'open',
                        child: Text('Відкрити'),
                      ),
                      const PopupMenuItem(
                        value: 'duplicate',
                        child: Text('Дублювати'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('GitHub статистика'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.goNamed('github'),
          ),

          const SizedBox(height: 20),
          const AdUnifiedBanner(), 
        ],
      ),
    );
  }
}

