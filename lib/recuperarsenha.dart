import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Classe principal da página de recuperação de senha
class RecuperarSenhaPage extends StatefulWidget {
  const RecuperarSenhaPage({Key? key}) : super(key: key);

  @override
  _RecuperarSenhaPageState createState() => _RecuperarSenhaPageState();
}

class _RecuperarSenhaPageState extends State<RecuperarSenhaPage> {
  final TextEditingController _cpfController = TextEditingController();
  bool _isCpfSubmitted = false;

  // Função para verificar o CPF
  void _verifyCpf() {
    setState(() {
      _isCpfSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar no topo da página
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white), // Seta de retorno branca
        title: const Text(
          'Recuperar Senha', // Título do AppBar
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black, // Cor de fundo do AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20), // Espaço entre o AppBar e o conteúdo
              const Text(
                'Esqueci a senha', // Título da página
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10), // Espaço entre o título e a descrição
              Text(
                _isCpfSubmitted
                    ? 'Confirme se este é seu e-mail' // Mensagem após submissão do CPF
                    : 'Vamos fazer sua verificação no nosso banco de dados primeiro', // Mensagem inicial
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20), // Espaço entre a descrição e o formulário
              if (!_isCpfSubmitted)
                TextFormField(
                  controller: _cpfController,
                  decoration: const InputDecoration(
                    labelText: 'CPF', // Rótulo do campo de texto
                    prefixIcon: Icon(Icons.assignment_ind), // Ícone do campo
                    hintText: '123.456.789-00', // Texto de dica
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                    _CpfInputFormatter(), // Formata o CPF enquanto digita
                  ],
                )
              else
                const Text(
                  'email@email.com', // Exibe o e-mail após submissão do CPF
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 20),
              if (!_isCpfSubmitted)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _verifyCpf,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Cor do texto
                      backgroundColor: Colors.black, // Cor do botão
                      padding: const EdgeInsets.symmetric(vertical: 15), // Padding vertical
                    ),
                    child: const Text('Verificar'), // Texto do botão
                  ),
                )
              else
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Ação para enviar o código
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text('Enviar Código'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Ação para caso o usuário não tenha acesso ao e-mail
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text('Não tenho acesso a esse e-mail'),
                      ),
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

// Formatação do CPF enquanto digita
class _CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length > 11) return oldValue;

    String newText = _formatCpf(newValue.text);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _formatCpf(String cpf) {
    if (cpf.isEmpty) return cpf;
    if (cpf.length <= 3) return cpf;
    if (cpf.length <= 6) return '${cpf.substring(0, 3)}.${cpf.substring(3)}';
    if (cpf.length <= 9) return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6)}';
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}';
  }
}
