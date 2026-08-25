import 'package:flutter/material.dart';
import 'database_helper.dart';

class UsuariosTabela extends StatefulWidget {
  const UsuariosTabela({super.key});

  @override
  State<UsuariosTabela> createState() => _UsuariosTabelaState();
}

class _UsuariosTabelaState extends State<UsuariosTabela> {
  List<Map<String, dynamic>> _usuarios = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarUsuarios();
  }

  Future<void> _carregarUsuarios() async {
    final users = await DatabaseHelper.getUsuarios();
    setState(() {
      _usuarios = users;
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabela de Usuários'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Table(
                  border: TableBorder.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  children: [
                    // Cabeçalho da tabela
                    TableRow(
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                      ),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'ID',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Nome',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    // Linhas dinâmicas dos usuários
                    ..._usuarios.map((user) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(user['id']?.toString() ?? ''),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(user['nome']?.toString() ?? ''),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(user['email']?.toString() ?? ''),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(user['status']?.toString() ?? 'Ativo'),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
    );
  }
}
