import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:user_card/repo_model.dart';

Future<List<Repo>> getRepos() async {
  final dio = Dio();
  final Response response =
      await dio.get('https://api.github.com/users/leonardfreitas/repos');

  final repos =
      (response.data as List).map((value) => Repo.fromMap(value)).toList();

  return repos;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Repo>>(
        future: getRepos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro a carregar dados'));
          } else {
            final repos = snapshot.data!;
            return ListView.builder(
              itemCount: repos.length,
              itemBuilder: (context, index) {
                final repo = repos[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      repo.userImage,
                    ),
                  ),
                  title: Text(repo.name),
                  subtitle: Text(repo.fullName),
                );
              },
            );
          }
        },
      ),
    );
  }
}
