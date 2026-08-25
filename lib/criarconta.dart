import 'package:flutter/material.dart';
import 'usuariostabela.dart';
import 'database_helper.dart';

class CriarConta extends StatefulWidget {
  const CriarConta({super.key});

  @override
  State<CriarConta> createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _carregando = false;

  Future<void> _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _carregando = true;
      });

      final nome = _nomeController.text.trim();
      final email = _emailController.text.trim();
      final senha = _senhaController.text;

      await DatabaseHelper.inserirUsuario(nome, email, senha);

      setState(() {
        _carregando = false;
      });

      if (!mounted) return;

      // Sucesso - exibir SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Conta criada com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );

      // Redirecionar para a tabela de usuários
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UsuariosTabela()),
      );
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.person_add_alt, size: 80, color: Colors.red),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome Completo",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Por favor, digite seu nome completo";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Por favor, digite seu e-mail";
                  }
                  if (!value.contains('@')) {
                    return "Por favor, digite um e-mail válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, digite sua senha";
                  }
                  if (value.length < 3) {
                    return "A senha deve ter pelo menos 3 caracteres";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _carregando ? null : _cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: _carregando
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text("Cadastrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
