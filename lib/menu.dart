import 'package:flutter/material.dart';
import 'login.dart'; // Importa a página de login
import 'AgendarAulasPage.dart'; // Importa a página de agendar aulas

// Classe principal do Menu
class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  // Método build para construir a interface do Menu
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar no topo da página
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove o botão de voltar
        title: const Text(
          'Menu', // Título do AppBar
          style: TextStyle(color: Colors.white), // Cor branca para o título
        ),
        centerTitle: true, // Centraliza o título no AppBar
        backgroundColor: Colors.black, // Cor de fundo do AppBar
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20), // Espaço entre o AppBar e o conteúdo
                // Foto 3x4 e mensagem de boas-vindas
                Column(
                  children: [
                    CircleAvatar(
                      radius: 60, // Tamanho do avatar circular
                      backgroundImage: AssetImage(
                          'assets/user.png'), // Imagem do usuário
                    ),
                    const SizedBox(height: 10), // Espaço entre a imagem e o texto
                    const Text(
                      'Bem-vindo Caio Josef', // Mensagem de boas-vindas
                      style: TextStyle(
                        fontSize: 18, // Tamanho da fonte
                        fontWeight: FontWeight.bold, // Texto em negrito
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Espaço entre a mensagem e os botões
                // Botão para agendar aulas
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AgendarAulasPage(), // Navega para a página de agendar aulas
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Cor do texto
                      backgroundColor: Colors.black, // Cor do botão
                      padding: const EdgeInsets.symmetric(vertical: 15), // Padding vertical
                    ),
                    child: const Text('Agendar Aula'), // Texto do botão
                  ),
                ),
                const SizedBox(height: 10), // Espaço entre os botões
                // Botão para montar treino
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Ação do botão Montar Treino
                      _showComingSoonDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Montar Treino'),
                  ),
                ),
                const SizedBox(height: 10),
                // Botão para consultar mensalidade
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Ação do botão Consultar Mensalidade
                      _showComingSoonDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Consultar Mensalidade'),
                  ),
                ),
                const SizedBox(height: 10),
                // Botão para falar conosco
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Ação do botão Fale Conosco
                      _showComingSoonDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Fale Conosco'),
                  ),
                ),
                const SizedBox(height: 20),
                // Logo da academia abaixo dos botões
                Image.asset(
                  'assets/logo_academia.png', // Imagem do logo da academia
                  height: 100, // Altura da imagem
                ),
              ],
            ),
          ),
        ),
      ),
      // Botão flutuante para logout
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()), // Navega para a página de login
            (Route<dynamic> route) => false, // Remove todas as páginas anteriores
          );
        },
        backgroundColor: Colors.black, // Cor de fundo do botão
        child: const Icon(Icons.logout, color: Colors.white), // Ícone de logout
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Localização do botão flutuante
    );
  }

  // Mostra um diálogo de "Em breve" para funcionalidades não implementadas
  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Em breve'),
          content: const Text('Esta funcionalidade estará disponível em breve.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
