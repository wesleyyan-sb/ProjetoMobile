import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        secondaryHeaderColor: Colors.redAccent,
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
  bool _carr = true;

  final TextEditingController _searchController =
      TextEditingController();

  double _opacidade = 0.0;

  String _localizacao = 'Consultando localização...';

  final List<Map<String, dynamic>> _estacionamentos = [
    {
      'nome': 'Estacionamento Central',
      'endereco': 'Rua XV de Novembro',
      'vagas': 12,
    },
    {
      'nome': 'Park Fácil',
      'endereco': 'Rua das Palmeiras',
      'vagas': 8,
    },
  ];

  @override
  void initState() {
    super.initState();

    _buscarLocalizacao();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;

      setState(() {
        _carr = false;
      });
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;

      setState(() {
        _opacidade = 1.0;
      });
    });
  }

  Future<void> _buscarLocalizacao() async {
    setState(() {
      _localizacao = 'Consultando localização...';
    });

    try {
      final resposta = await http
          .get(Uri.parse('https://ipwho.is/'))
          .timeout(const Duration(seconds: 8));

      if (resposta.statusCode == 200) {
        final dados = jsonDecode(resposta.body);

        if (dados['success'] == true && mounted) {
          final cidade = dados['city'] ?? 'cidade desconhecida';
          final regiao = dados['region'] ?? 'região desconhecida';
          final pais = dados['country'] ?? 'país desconhecido';

          setState(() {
            _localizacao = '$cidade, $regiao, $pais';
          });
        } else if (mounted) {
          setState(() {
            _localizacao = 'localização indisponível.';
          });
        }
      } else if (mounted) {
        setState(() {
          _localizacao = 'não foi possível consultar a localização.';
        });
      }
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _localizacao = 'erro ao consultar a localização.';
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _construirEstacionamento(
    Map<String, dynamic> estacionamento,
  ) {
    final int vagas = estacionamento['vagas'] as int;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              estacionamento['nome'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(estacionamento['endereco'] as String),
            const SizedBox(height: 8),
            Text(
              vagas > 0 ? '$vagas vagas disponíveis' : 'Lotado',
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final termo = _searchController.text.trim().toLowerCase();

    final estacionamentosFiltrados = _estacionamentos.where((e) {
      final nome = (e['nome'] as String).toLowerCase();
      final endereco = (e['endereco'] as String).toLowerCase();

      return nome.contains(termo) || endereco.contains(termo);
    }).toList();

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
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Calculadora'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Calculo(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('Vagas'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Disponibilidade(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Config(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // INTRODUÇÃO DO APP: aparece primeiro.
                AnimatedOpacity(
                  duration: const Duration(seconds: 2),
                  opacity: _opacidade,
                  child: Column(
                    children: [
                      Text(
                        'EstacionaAí',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Bem-vindo! Faça login para continuar.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CriarConta(),
                          ),
                        );
                      },
                      child: const Text('Criar conta'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Entrar(),
                          ),
                        );
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // PESQUISA DE ESTACIONAMENTOS.
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    labelText: 'Buscar estacionamento...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Sua localização',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_localizacao),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _buscarLocalizacao,
                          child: const Text('Atualizar localização'),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Estacionamentos próximos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                if (estacionamentosFiltrados.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Nenhum estacionamento encontrado.',
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  ...estacionamentosFiltrados.map(
                    _construirEstacionamento,
                  ),

                const SizedBox(height: 24),

                const Divider(),

                const Text(
                  'Unidades:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('São Paulo'),
                ),
                const ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Rio do Sul'),
                ),
                const ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('João Pessoa'),
                ),

                const SizedBox(height: 20),

                const Text(
                  'A EstacionaAí oferece soluções modernas de '
                  'estacionamento no Brasil.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),

                const SizedBox(height: 20),

                const SizedBox(height: 20),
              ],
            ),
          ),

          if (_carr)
            Container(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/loading.gif',
                  width: 220,
                ),
              ),
            ),
        ],
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.grey[200],
        child: const Text(
          '© 2026 EstacionaAí',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
