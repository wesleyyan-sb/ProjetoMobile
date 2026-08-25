<img src="./assets/ifc.png" width="400">

# EstacionaAí

**EstacionaAí** é um protótipo de aplicativo desenvolvido em **Flutter** para a disciplina de **Programação para Dispositivos Móveis (Mobile)**. O objetivo principal do aplicativo é auxiliar motoristas a encontrar, calcular e simular a disponibilidade de vagas de estacionamento em unidades distribuídas pelo Brasil.

---

## Funcionalidades Principais

*   **Tela Inicial Dinâmica**:
    *   Animações de entrada (opacidade e movimentação suave de elementos).
    *   Barra de pesquisa e listagem de unidades ativas (São Paulo, Rio do Sul, João Pessoa).
    *   *Splash Screen* nativa simulada (GIF de carregamento exibido por 4 segundos ao abrir o app).
*   **Controle de Acesso e Contas**:
    *   **Login**: Entrada segura validando e-mail e senha diretamente no banco de dados local.
    *   **Criação de Conta**: Cadastro de novos usuários (Nome Completo, E-mail e Senha) com inserção direta no banco de dados.
    *   **Validação de Formulários**: Todos os formulários possuem validação nativa de campos obrigatórios, regras de formato de e-mail e requisitos mínimos de senha (mínimo de 3 caracteres) para evitar dados inconsistentes.
*   **Banco de Dados Integrado (SQLite + Fallback Web)**:
    *   Utiliza **SQLite** (`sqflite`) para persistência de dados real em dispositivos Android/iOS e emuladores.
    *   Possui um sistema inteligente de **Fallback em Memória para Web**: Se executado no navegador Chrome, o app simula as tabelas em memória, permitindo testar o fluxo de login, cadastro e edição sem erros de drivers.
*   **Tabela de Usuários Dinâmica**:
    *   Lista em formato tabular todos os usuários cadastrados.
    *   Os dados são buscados de forma assíncrona no banco e renderizados dinamicamente na tela.
*   **Calculadora de Preços**:
    *   Permite simular o preço do estacionamento com base em uma taxa de R$ 10,00 por hora trabalhada.
*   **Disponibilidade de Vagas**:
    *   Gráfico simples mostrando vagas disponíveis e ocupadas com um botão interativo para simular a entrada de novos veículos e ocupação de vagas em tempo real.
*   **Configurações de Perfil**:
    *   **Exibição de Conta**: Mostra o nome e o e-mail do usuário ativo (ou "Visitante").
    *   **Editar Perfil**: Permite a alteração do e-mail do usuário logado diretamente no banco de dados através de um diálogo de validação.
    *   **Resetar Banco de Dados**: Botão para redefinir as tabelas de dados de volta ao "modo de fábrica", excluindo dados criados e re-semeando o banco com os 5 usuários de teste originais da tabela.

---

## 🛠️ Tecnologias e Dependências Utilizadas

*   **SDK**: Flutter (Dart >= 3.11.1)
*   **Persistência**: `sqflite: ^2.3.0` (SQLite nativo)
*   **Manipulação de Arquivos**: `path: ^1.9.0`
*   **Interface**: Material Design 3

---

## 📁 Estrutura de Arquivos (`lib/`)

```txt
lib/
├── main.dart             # Ponto de partida, splash screen e tela inicial.
├── entrar.dart           # Tela de login com validação e consulta ao banco.
├── criarconta.dart       # Tela de registro com validação e inserção.
├── database_helper.dart  # Lógica de persistência SQLite com fallback web.
├── usuariostabela.dart   # Tabela carregada dinamicamente com dados do banco.
├── config.dart           # Edição de e-mail de perfil e reset de tabelas.
├── calculo.dart          # Calculadora de preços baseada em horas.
└── disponibilidade.dart  # Simulador interativo de entrada de veículos.
```

---

## Como Executar o Projeto

Certifique-se de que possui o ambiente **Flutter** instalado e configurado no seu sistema Linux.

1.  Clone este repositório ou navegue até a pasta do projeto:
    ```bash
    cd ProjetoMobile2
    ```

2.  Instale os pacotes e dependências adicionadas (`sqflite` e `path`):
    ```bash
    flutter pub get
    ```

3.  Execute o aplicativo:

    *   **Para testar no Navegador (Web)**:
        ```bash
        flutter run -d chrome
        ```
    *   **Para rodar nativamente no Linux**:
        ```bash
        flutter run -d linux
        ```
    *   **Para rodar no Emulador Android/Celular conectado**:
        ```bash
        flutter run
        ```
