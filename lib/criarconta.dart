import 'package:flutter/material.dart';
import 'usuariostabela.dart';

class CriarConta extends StatelessWidget {
  const CriarConta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Conta"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ), 
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.person_add_alt, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: "Nome Completo",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                labelText: "E-mail",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UsuariosTabela()),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                child: const Text("Cadastrar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
