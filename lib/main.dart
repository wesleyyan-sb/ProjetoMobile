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
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
        drawer: Drawer(
    child: ListView(
      children: [
        DrawerHeader(
          child: Text("Menu"),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Início"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Configurações"),
          onTap: () {},
        ),
      ],
    ),
  ),
      body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Buscar unidade...',
          prefixIcon: Icon(Icons.search),
        ),
      ),
      Text('EstacionaAí', style: Theme.of(context).textTheme.displayLarge),
      const Text('Bem vindo! Crie uma conta ou faça login para continuar.'),
      ElevatedButton(onPressed: () {

        ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text("Apenas teste!"), 
  duration: Duration(seconds: 2),
  ),
);
      }, child: Text("Criar conta")),
      const SizedBox(height: 16),
      ElevatedButton(onPressed: () {


        ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text("Apenas teste!"),
    duration: Duration(seconds: 2),
  ),
);
      }, child: Text("Fazer login")),
            Divider(
        height: 20,
        thickness: 2,
        indent: 10,
        endIndent: 10,
        color: Colors.white,
      ),
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
            Padding(
              padding: EdgeInsets.all(16.0), //preciso rever ainda
              child: Text(
                'A EstacionaAí é uma empresa fundada em Rio do Sul, que disponibiliza estacionamentos nas principais cidades do Brasil com eficiencia e responsabilidade.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
),
  bottomNavigationBar: Container(
    padding: EdgeInsets.all(16),
    color: Colors.grey[200],
    child: Text(
      "© 2026 EstacionaAí",
      textAlign: TextAlign.center,
    ),
  )
    );
    
  }
}
