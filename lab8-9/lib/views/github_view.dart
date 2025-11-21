import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/github_viewmodel.dart';

class GithubView extends StatefulWidget {
  const GithubView({Key? key}) : super(key: key);

  @override
  State<GithubView> createState() => _GithubViewState();
}

class _GithubViewState extends State<GithubView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<GithubViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub статистика'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'GitHub username',
                hintText: 'наприклад: sa1nss',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                final username = _controller.text.trim();
                if (username.isNotEmpty) {
                  vm.fetchUser(username);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Введіть username')),
                  );
                }
              },
              child: const Text('Пошук'),
            ),
            const SizedBox(height: 16),

            if (vm.state == GithubState.loading)
              const CircularProgressIndicator()
            else if (vm.state == GithubState.error)
              Text(vm.errorMessage ?? 'Невідома помилка',
                  style: const TextStyle(color: Colors.red))
            else if (vm.state == GithubState.loaded && vm.user != null)
              _buildUser(vm.user!)
            else
              const Text('Введіть username і натисніть Пошук'),
          ],
        ),
      ),
    );
  }

  Widget _buildUser(user) {
    return Column(
      children: [
        const SizedBox(height: 16),
        CircleAvatar(radius: 40, backgroundImage: NetworkImage(user.avatarUrl)),
        const SizedBox(height: 8),
        Text(
          user.name.isNotEmpty ? user.name : user.login,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('@${user.login}', style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        if (user.bio.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(user.bio, textAlign: TextAlign.center),
          ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _statColumn('Repos', user.publicRepos.toString()),
            _statColumn('Followers', user.followers.toString()),
            _statColumn('Following', user.following.toString()),
          ],
        ),
      ],
    );
  }

  Widget _statColumn(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
