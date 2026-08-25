import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static final List<Map<String, dynamic>> _mockDb = [
    {'id': 1, 'nome': 'João Silva', 'email': 'joao@email.com', 'senha': '123', 'status': 'Ativo'},
    {'id': 2, 'nome': 'Maria Santos', 'email': 'maria@email.com', 'senha': '123', 'status': 'Ativo'},
    {'id': 3, 'nome': 'Pedro Oliveira', 'email': 'pedro@email.com', 'senha': '123', 'status': 'Inativo'},
    {'id': 4, 'nome': 'Ana Costa', 'email': 'ana@email.com', 'senha': '123', 'status': 'Ativo'},
    {'id': 5, 'nome': 'Carlos Ferreira', 'email': 'carlos@email.com', 'senha': '123', 'status': 'Ativo'},
  ];

  static Map<String, dynamic>? usuarioLogado;

  static sql.Database? _database;

  static Future<sql.Database?> get database async {
    if (kIsWeb) return null;
    if (_database != null) return _database;
    try {
      _database = await _initDatabase();
      return _database;
    } catch (e) {
      debugPrint("Erro ao inicializar sqflite, usando fallback em memória: $e");
      return null;
    }
  }

  static Future<sql.Database> _initDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    final databasePath = path.join(dbPath, 'estaciona_ai.db');

    return await sql.openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE usuarios(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            email TEXT,
            senha TEXT,
            status TEXT
          )
        ''');

        for (var user in _mockDb) {
          await db.insert('usuarios', {
            'nome': user['nome'],
            'email': user['email'],
            'senha': user['senha'],
            'status': user['status'],
          });
        }
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getUsuarios() async {
    if (kIsWeb) {
      return List<Map<String, dynamic>>.from(_mockDb);
    }
    final db = await database;
    if (db == null) {
      return List<Map<String, dynamic>>.from(_mockDb);
    }
    return await db.query('usuarios');
  }

  static Future<void> inserirUsuario(String nome, String email, String senha) async {
    final Map<String, dynamic> novoUsuario = {
      'nome': nome,
      'email': email,
      'senha': senha,
      'status': 'Ativo',
    };

    if (kIsWeb) {
      novoUsuario['id'] = _mockDb.length + 1;
      _mockDb.add(novoUsuario);
      usuarioLogado = novoUsuario;
      return;
    }

    final db = await database;
    if (db == null) {
      novoUsuario['id'] = _mockDb.length + 1;
      _mockDb.add(novoUsuario);
      usuarioLogado = novoUsuario;
      return;
    }

    final id = await db.insert('usuarios', novoUsuario);
    usuarioLogado = {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'status': 'Ativo',
    };
  }

  static Future<Map<String, dynamic>?> fazerLogin(String email, String senha) async {
    if (kIsWeb) {
      try {
        final user = _mockDb.firstWhere(
          (u) => u['email'] == email && u['senha'] == senha,
        );
        usuarioLogado = Map<String, dynamic>.from(user);
        return usuarioLogado;
      } catch (_) {
        return null;
      }
    }

    final db = await database;
    if (db == null) {
      try {
        final user = _mockDb.firstWhere(
          (u) => u['email'] == email && u['senha'] == senha,
        );
        usuarioLogado = Map<String, dynamic>.from(user);
        return usuarioLogado;
      } catch (_) {
        return null;
      }
    }

    final result = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );

    if (result.isEmpty) return null;
    usuarioLogado = Map<String, dynamic>.from(result.first);
    return usuarioLogado;
  }

  static Future<void> atualizarEmail(int id, String novoEmail) async {
    if (kIsWeb) {
      final index = _mockDb.indexWhere((u) => u['id'] == id);
      if (index != -1) {
        _mockDb[index] = Map<String, dynamic>.from(_mockDb[index])..['email'] = novoEmail;
        if (usuarioLogado != null && usuarioLogado!['id'] == id) {
          usuarioLogado = _mockDb[index];
        }
      }
      return;
    }

    final db = await database;
    if (db == null) {
      final index = _mockDb.indexWhere((u) => u['id'] == id);
      if (index != -1) {
        _mockDb[index] = Map<String, dynamic>.from(_mockDb[index])..['email'] = novoEmail;
        if (usuarioLogado != null && usuarioLogado!['id'] == id) {
          usuarioLogado = _mockDb[index];
        }
      }
      return;
    }

    await db.update(
      'usuarios',
      {'email': novoEmail},
      where: 'id = ?',
      whereArgs: [id],
    );

    if (usuarioLogado != null && usuarioLogado!['id'] == id) {
      final result = await db.query('usuarios', where: 'id = ?', whereArgs: [id]);
      if (result.isNotEmpty) {
        usuarioLogado = Map<String, dynamic>.from(result.first);
      }
    }
  }

  static Future<void> resetarBancoDados() async {
    usuarioLogado = null;

    _mockDb.clear();
    _mockDb.addAll([
      {'id': 1, 'nome': 'João Silva', 'email': 'joao@email.com', 'senha': '123', 'status': 'Ativo'},
      {'id': 2, 'nome': 'Maria Santos', 'email': 'maria@email.com', 'senha': '123', 'status': 'Ativo'},
      {'id': 3, 'nome': 'Pedro Oliveira', 'email': 'pedro@email.com', 'senha': '123', 'status': 'Inativo'},
      {'id': 4, 'nome': 'Ana Costa', 'email': 'ana@email.com', 'senha': '123', 'status': 'Ativo'},
      {'id': 5, 'nome': 'Carlos Ferreira', 'email': 'carlos@email.com', 'senha': '123', 'status': 'Ativo'},
    ]);

    if (kIsWeb) return;

    final db = await database;
    if (db == null) return;

    await db.execute('DROP TABLE IF EXISTS usuarios');
    await db.execute('''
      CREATE TABLE usuarios(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        email TEXT,
        senha TEXT,
        status TEXT
      )
    ''');

    for (var user in _mockDb) {
      await db.insert('usuarios', {
        'nome': user['nome'],
        'email': user['email'],
        'senha': user['senha'],
        'status': user['status'],
      });
    }
  }
}
