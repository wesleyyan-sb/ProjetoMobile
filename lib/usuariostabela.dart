import 'package:flutter/material.dart';

class UsuariosTabela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabela de Usuários'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Table(
            border: TableBorder.all(
              color: Colors.grey,
              width: 1,
            ),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                ),
                children: [
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
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('1'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('João Silva'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('joao@email.com'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Ativo'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('2'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Maria Santos'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('maria@email.com'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Ativo'),
                  ), 
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('3'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Pedro Oliveira'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('pedro@email.com'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Inativo'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('4'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Ana Costa'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('ana@email.com'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Ativo'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('5'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Carlos Ferreira'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('carlos@email.com'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Ativo'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
