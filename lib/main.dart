import 'package:flutter/material.dart';
import 'config.dart';
import 'entrar.dart';
import 'criarconta.dart';
import 'calculo.dart';
import 'disponibilidade.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EstacionaAí',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'EstacionaAí'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  
  // Variáveis para as animações
  double _opacidade = 0.0;
  double _espacamentoSuperior = 50.0;

  @override
  void initState() {
    super.initState();
    // Inicia as animações assim que a tela abre
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacidade = 1.0;
        _espacamentoSuperior = 20.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Início"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text("Calculadora"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Calculo()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text("Vagas"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Disponibilidade()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configurações"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Config()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ANIMAÇÃO 1: Deslocamento suave (AnimatedPadding)
            AnimatedPadding(
              duration: const Duration(seconds: 1),
              padding: EdgeInsets.only(top: _espacamentoSuperior),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Buscar unidade...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // ANIMAÇÃO 2: Aparecimento suave (AnimatedOpacity)
            AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: _opacidade,
              child: Column(
                children: [
                  Text('EstacionaAí', style: Theme.of(context).textTheme.headlineMedium),
                  const Text('Bem vindo! Faça login para continuar.'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CriarConta()));
                  },
                  child: const Text("Conta"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Entrar()));
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text('Unidades:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const ListTile(leading: Icon(Icons.location_on), title: Text("São Paulo")),
            const ListTile(leading: Icon(Icons.location_on), title: Text("Rio do Sul")),
            const ListTile(leading: Icon(Icons.location_on), title: Text("João Pessoa")),
            const SizedBox(height: 20),
            const Text(
              'A EstacionaAí oferece soluções modernas de estacionamento no Brasil.',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.grey[200],
        child: const Text("© 2026 EstacionaAí", textAlign: TextAlign.center),
      ),
    );
  }
}
