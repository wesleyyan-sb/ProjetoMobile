import 'package:flutter/material.dart';
import 'database_helper.dart';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  // Mostra o diálogo para editar o e-mail do usuário logado
  void _mostrarDialogoEditar() {
    final usuario = DatabaseHelper.usuarioLogado;
    if (usuario == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor, faça login ou crie uma conta para editar seu perfil."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final formKeyDialog = GlobalKey<FormState>();
    final controllerEmail = TextEditingController(text: usuario['email']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar E-mail"),
          content: Form(
            key: formKeyDialog,
            child: TextFormField(
              controller: controllerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Novo E-mail",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "O e-mail não pode ser vazio";
                }
                if (!value.contains('@')) {
                  return "Digite um e-mail válido";
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKeyDialog.currentState!.validate()) {
                  final novoEmail = controllerEmail.text.trim();
                  await DatabaseHelper.atualizarEmail(usuario['id'], novoEmail);
                  
                  if (mounted) {
                    Navigator.pop(context);
                    setState(() {}); // Atualiza a tela de configurações com o novo email
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("E-mail atualizado com sucesso!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  // Mostra o diálogo para confirmar a restauração do banco de dados ao original
  void _confirmarReset() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Resetar Banco de Dados?"),
          content: const Text(
            "Isso apagará todas as contas criadas e restaurará os 5 usuários originais. Você será desconectado da conta atual.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper.resetarBancoDados();
                if (mounted) {
                  Navigator.pop(context); // Fecha o diálogo
                  setState(() {}); // Atualiza a tela de configurações
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Banco de dados restaurado ao original!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text("Resetar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuario = DatabaseHelper.usuarioLogado;
    final nomeUsuario = usuario != null ? usuario['nome'] : "Visitante";
    final emailUsuario = usuario != null ? usuario['email'] : "sem-cadastro@email.com";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text("Perfil", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(nomeUsuario),
            subtitle: Text(emailUsuario),
          ),
          ElevatedButton(
            onPressed: _mostrarDialogoEditar,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text("Editar Perfil"),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: _confirmarReset,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
            child: const Text("Resetar Banco de Dados"),
          ),
          const SizedBox(height: 20),
          const Text("Preferências", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text("Notificações"),
            value: true,
            onChanged: (bool value) {},
          ),
          const SizedBox(height: 20),
          const Text("Sobre", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const ListTile(
            title: Text("Versão"),
            trailing: Text("1.0.0"),
          ),
        ],
      ),
    );
  }
}
