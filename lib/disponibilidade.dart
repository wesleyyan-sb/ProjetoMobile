import 'package:flutter/material.dart';

class Disponibilidade extends StatefulWidget {
  const Disponibilidade({super.key});

  @override
  State<Disponibilidade> createState() => _DisponibilidadeState();
}

class _DisponibilidadeState extends State<Disponibilidade> {
  int totalVagas = 50;
  int ocupadas = 12;

  @override
  Widget build(BuildContext context) {
    int disponiveis = totalVagas - ocupadas;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Vagas Disponíveis"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_parking, size: 100, color: Colors.red),
            const SizedBox(height: 20),
            Text("Total de Vagas: $totalVagas"),
            Text("Vagas Ocupadas: $ocupadas"),
            const Divider(indent: 100, endIndent: 100),
            Text(
              "Disponíveis: $disponiveis",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (ocupadas < totalVagas) ocupadas++;
                });
              },
              child: const Text("Simular Entrada de Veículo"),
            ),
          ],
        ),
      ),
    );
  }
}
