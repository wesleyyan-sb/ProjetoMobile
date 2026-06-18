# CHANGELOG - Atualizações do Projeto EstacionaAí

Este arquivo detalha todas as alterações realizadas para cumprir os requisitos da atividade prática.

## [1.0.1] - 2026-06-18

### Adicionado
- **Nova Tela: Calculadora de Preços (`lib/calculo.dart`)**
  - **O que faz:** Permite ao usuário inserir a quantidade de horas que o veículo ficou no estacionamento e calcula o valor total.
  - **Como faz:** Utiliza um `TextField` com teclado numérico para entrada de dados e uma função que multiplica o valor digitado por uma taxa fixa de R$ 10,00.
  - **Por que:** Para cumprir o requisito de "Processamento (cálculos)" e "Novas telas". Usa `StatefulWidget` para gerenciar o estado do cálculo e um widget customizado `Stateless` para exibir o resultado.

- **Nova Tela: Disponibilidade de Vagas (`lib/disponibilidade.dart`)**
  - **O que faz:** Exibe o total de vagas, quantas estão ocupadas e calcula automaticamente quantas estão disponíveis.
  - **Como faz:** Realiza uma subtração simples (`total - ocupadas`). Inclui um botão que simula a entrada de um novo veículo, incrementando o contador e atualizando a tela em tempo real com `setState`.
  - **Por que:** Segunda tela obrigatória. Demonstra processamento lógico de dados e interação com o estado da aplicação.

### Adicionado
- **Animações Básicas na Home (`lib/main.dart`)**
  - **Animação 1 (Fade-in):** Utilização do widget `AnimatedOpacity` para fazer com que o título e a mensagem de boas-vindas apareçam suavemente (efeito de transparência) ao abrir o app.
  - **Animação 2 (Deslocamento):** Utilização do widget `AnimatedPadding` no campo de busca para criar um efeito de entrada suave, onde o campo "escorrega" de cima para baixo até sua posição final.
  - **Por que:** Para cumprir o requisito de "Adicionar animações". Foram escolhidas animações implícitas por serem simples de implementar e fáceis de explicar tecnicamente.

### Alterado
- **Renomeação Geral de Arquivos e Classes**
  - Os arquivos foram renomeados para termos mais simples e naturais em português (ex: `login_page.dart` virou `entrar.dart`).
  - O arquivo `ajustes.dart` foi renomeado para `config.dart` para manter um padrão técnico comum.
  - As classes internas foram simplificadas para facilitar a explicação do código (ex: `RegisterPage` virou `CriarConta`).
  - **Por que:** Para deixar o projeto com uma estrutura mais limpa, informal e menos "robótica", facilitando a apresentação para o professor.

- **Navegação Principal (`lib/main.dart`)**
  - **O que foi feito:** O menu lateral (`Drawer`) foi atualizado para incluir os links para as novas telas de "Calculadora" e "Vagas".
  - **Como faz:** Adicionado novos `ListTile` com ícones pertinentes (`calculate` e `directions_car`) que utilizam o `Navigator.push` para abrir as telas.

- **Organização de Importações**
  - Todos os arquivos `import` no `main.dart` foram atualizados para refletir os novos nomes dos arquivos `.dart`.

### Técnico
- **Widgets Stateless e Stateful:** O projeto agora faz uso equilibrado de ambos. Telas fixas como Login são `Stateless`, enquanto as telas de cálculo e vagas são `Stateful`.
- **Lógica de Negócio:** Implementada diretamente nos métodos das classes `State`, mantendo o código conciso e fácil de explicar.

# Guia Técnico de Estilização e Alterações (CHANGELOG)

Este documento detalha como a estilização foi aplicada no projeto, servindo como guia de estudo.

## [0.2.0] - Telas de Acesso e Navegação
- **Novos Arquivos:** `login_page.dart` e `register_page.dart`.
- **Navegação:** Uso do `Navigator.push` com `MaterialPageRoute` para empilhar as novas telas sobre a principal.

## [0.1.0] - Estilização e Tematização (O Coração do Visual)

Abaixo estão os conceitos e códigos utilizados para mudar a cara do app sem complicar o código:

### 1. O Tema Global (`lib/main.dart`)
O Flutter usa o widget `ThemeData` para definir as regras visuais de todo o app em um só lugar.
- **Onde fica:** Dentro do `MaterialApp`.
- **Como funciona:** 
  ```dart
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red), // Define a cor principal
    useMaterial3: true, // Habilita o design moderno do Android
  )
  ```
- **Por que usamos:** Isso evita que tenhamos que colocar `color: Colors.red` em cada botão. O Flutter entende que a "cor semente" é vermelha e gera tons automáticos para o resto do app.

### 2. Organização de Layout (`lib/main.dart`)
- **SingleChildScrollView:** Usado para envolver o `body`. Ele permite que a tela tenha "scroll" (role para baixo) se o conteúdo for maior que a tela do celular, evitando o erro de "overflow" (aquelas listras amarelas e pretas).
- **TextField (Busca):**
  ```dart
  decoration: const InputDecoration(
    labelText: 'Buscar...',
    border: OutlineInputBorder(), // Cria a bordinha ao redor do campo
    prefixIcon: Icon(Icons.search), // Coloca o ícone de lupa dentro do campo
  )
  ```

### 3. Navegação Lateral (Drawer)
- **Onde fica:** Propriedade `drawer` do `Scaffold`.
- **Como funciona:** O `DrawerHeader` cria o topo colorido do menu. Cada `ListTile` funciona como um botão de lista que, ao ser clicado (`onTap`), executa o comando para mudar de tela.

### 4. Componentes de Lista (ListTile e Divider)
- **ListTile:** Usamos nas Unidades (São Paulo, etc.). Ele já vem com espaços prontos para ícone (`leading`), título (`title`) e subtítulo.
- **Divider:** Uma linha horizontal simples usada para separar visualmente as seções da página.

### 5. Estilização da Tela de Configurações (`lib/config.dart`)
- **SwitchListTile:** Um widget pronto que combina um texto com uma "chave" de ligar/desligar. É ideal para configurações de notificações.
- **ListView:** Diferente da `Column`, o `ListView` já vem com scroll automático e é otimizado para listas de itens.

### 6. Padronização de Cores Manual
Sempre que quisermos destaque manual (como na AppBar), usamos:
- `backgroundColor: Colors.red`
- `foregroundColor: Colors.white` (Isso garante que o texto e os ícones sobre o vermelho fiquem brancos e legíveis).
