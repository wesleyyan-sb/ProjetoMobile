import 'package:flutter/material.dart';

class Calculo extends StatefulWidget {
  const Calculo({super.key});

  @override
  State<Calculo> createState() => _CalculoState();
}

class _CalculoState extends State<Calculo> {
  final TextEditingController _hoursController = TextEditingController();
  double _totalFee = 0.0;

  void _calculateFee() {
    int hours = int.tryParse(_hoursController.text) ?? 0;
    setState(() {
      _totalFee = hours * 10.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Valor por hora: R\$ 10,00", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 15),
            TextField(
              controller: _hoursController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Quantidade de Horas",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _calculateFee,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
              child: const Text("Calcular"),
            ),
            const SizedBox(height: 20),
            ResultadoWidget(total: _totalFee),
          ],
        ),
      ),
    );
  }
}

class ResultadoWidget extends StatelessWidget {
  final double total;
  const ResultadoWidget({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Total: R\$ ${total.toStringAsFixed(2)}",
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
    );
  }
}
