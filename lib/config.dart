import 'package:flutter/material.dart';

class Config extends StatelessWidget {
  const Config({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text("Perfil", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Usuário"),
            subtitle: Text("usuario@email.com"),
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Editar Perfil")),
          const SizedBox(height: 20),
          const Text("Preferências", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text("Notificações"),
            value: true,
            onChanged: (bool value) {},
          ),
          const SizedBox(height: 20),
          const Text("Sobre", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const ListTile(
            title: Text("Versão"),
            trailing: Text("1.0.0"),
          ),
        ],
      ),
    );
  }
}
