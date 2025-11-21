import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/profile_viewmodel.dart';
import '../models/profile.dart';
import 'package:go_router/go_router.dart';
import '../theme/theme_provider.dart';   

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
            MaterialPageRoute(builder: (_) => const AddProfileForm()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: profiles.isEmpty
          ? const Center(child: Text("Немає збережених резюме"))
          : ListView(
              children: [
                ...profiles.map((profile) => Card(
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
                    )),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.code),
                  title: const Text('GitHub статистика'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => context.goNamed('github'),
                ),
              ],
            ),
    );
  }
}


class AddProfileForm extends StatefulWidget {
  const AddProfileForm({super.key});

  @override
  State<AddProfileForm> createState() => _AddProfileFormState();
}

class _AddProfileFormState extends State<AddProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Створити нове резюме')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Ім’я'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Введіть ім’я' : null,
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Посада / спеціальність'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: 'Про себе'),
                maxLines: 3,
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final vm = context.read<ProfileViewModel>();
                    final navigator = Navigator.of(context);

                    await vm.addProfile(
                      Profile(
                        name: _nameController.text,
                        title: _titleController.text,
                        email: _emailController.text,
                        bio: _bioController.text,
                      ),
                    );

                    navigator.pop();
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Зберегти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
