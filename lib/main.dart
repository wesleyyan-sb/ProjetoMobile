import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 0, 0)),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('EstacionaAí', style: Theme.of(context).textTheme.displayLarge),
      const Text('Bem vindo! Crie uma conta ou faça login para continuar.'),
      ElevatedButton(onPressed: null, child: Text("Criar conta")),
      Divider(
        height: 20,
        thickness: 2,
        indent: 10,
        endIndent: 10,
        color: Colors.white,
      ),
      ElevatedButton(onPressed: null, child: Text("Fazer login")),
      const Text('Nossas unidades:'),
      
      Expanded(
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.person),
              title: Text("São Paulo"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Rio do Sul"),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("João Pessoa"),
            ),
          ],
        ),
      ),
    ],
  ),
),
      
      
    );
    
  }
}
