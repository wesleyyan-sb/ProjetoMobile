import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Perfil"),
            const Text("Nome: Usuário"),
            const ElevatedButton(onPressed: null, child: Text("Editar Perfil")),
            const SizedBox(height: 20),
            const Text("Notificações"),
            const ElevatedButton(onPressed: null, child: Text("Ativar Notificações")),
            const SizedBox(height: 20),
            const Text("Sobre"),
            const Text("Versão 1.0.0"),
            const ElevatedButton(onPressed: null, child: Text("Ver Termos")),
          ],
        ),
      ),
    );
  }
}
