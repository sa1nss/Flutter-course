import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/profile_viewmodel.dart';
import '../models/profile.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProfileViewModel>();
    final profiles = vm.profiles;

    return Scaffold(
      appBar: AppBar(title: const Text('Резюме Білдер')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProfileForm()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          ...profiles.map((profile) => Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    icon: const Icon(Icons.more_vert),
                  ),
                ),
              )),

          const Divider(height: 32),

          // ==== Посилання на GitHub ====
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('GitHub статистика'),
            subtitle: const Text('Переглянути свій профіль GitHub'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              context.goNamed('github');
            },
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
    final vm = Provider.of<ProfileViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Створити нове резюме')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                decoration:
                    const InputDecoration(labelText: 'Посада / спеціальність'),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    vm.addProfile(Profile(
                      name: _nameController.text,
                      title: _titleController.text,
                      email: _emailController.text,
                      bio: _bioController.text,
                    ));
                    Navigator.pop(context);
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
