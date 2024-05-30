import 'package:flutter/material.dart';
import 'package:app_haircut/main.dart';//vai usar ainda
import 'package:app_haircut/data.dart';
import 'package:flutter/services.dart';

class RegistroUsuario extends StatelessWidget {
  RegistroUsuario({super.key});
  final TextEditingController  cpfController = TextEditingController();
  final TextEditingController  nomeUController = TextEditingController();
  final TextEditingController  senhaUController = TextEditingController();
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro como Usuário'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CPF do Usuário',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: cpfController,
              decoration: const InputDecoration(
                hintText: 'XXX.XXX.XXX-XX',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
                CpfMaskTextInputFormatter(), 
              ],
              ),

              
            const SizedBox(height: 20),
            const Text(
              'Nome do Usuário',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: nomeUController,
              decoration: const InputDecoration(
                hintText: 'Seu nome de usuário',
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            const Text(
              'Senha',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller:senhaUController,
              decoration: const InputDecoration(
                hintText: 'Senha',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            const Text(
              'Confirmar Senha',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Confirmar Senha',
              ),
              obscureText: true,
              ),



            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
              if (cpfController.text.isNotEmpty &&
              nomeUController.text.isNotEmpty &&
              senhaUController.text.isNotEmpty) {
                sendUserData({
                  "cpf": cpfController.text,
                  "nomeU": nomeUController.text,
                  "senhaU": senhaUController.text,
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                    );

                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Todos os campos são obrigatórios'),
                        ),
                        );
                        }
                        },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class CpfMaskTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    var newText = '';
    var index = 0;

    for (var i = 0; i < text.length; i++) {
      if (text[i] == '.' || text[i] == '-') {
        continue;
      }

      if (index == 3 || index == 6 ) {
        newText += '.';
      } else if (index == 9) {
        newText += '-';
      }

      newText += text[i];
      index++;
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}