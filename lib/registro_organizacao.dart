import 'package:flutter/material.dart';
import 'package:app_haircut/main.dart';//vai usar ainda
import 'package:app_haircut/data.dart';
import 'package:flutter/services.dart';


class RegistroOrganizacao extends StatelessWidget {
  RegistroOrganizacao({super.key});
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro como Organização'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CNPJ da Empresa',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: cnpjController,
              decoration: const InputDecoration(
                hintText: 'XX.XXX.XXX/0001-XX',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(14),
                CnpjMaskTextInputFormatter(),
                
              ],
            ),




            const SizedBox(height: 20),
            const Text(
              'Nome da Organização',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(
                hintText: 'Nome da sua organização',
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            const Text(
              'Senha',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: senhaController,
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
                if (cnpjController.text.isNotEmpty &&
                    nomeController.text.isNotEmpty &&
                    senhaController.text.isNotEmpty) {
                  sendOrganizationData({
                    "cnpj": cnpjController.text,
                    "nome_organizacao": nomeController.text,
                    "senha_organizacao": senhaController.text, 
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

class CnpjMaskTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    var newText = '';
    var index = 0;

    for (var i = 0; i < text.length; i++) {
      if (text[i] == '.' || text[i] == '/' || text[i] == '-') {
        continue;
      }

      if (index == 2 || index == 5) {
        newText += '.';
      } else if (index == 8) {
        newText += '/';
      } else if (index == 12) {
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