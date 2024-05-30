import 'package:app_haircut/gerenciamento.dart';
import 'package:flutter/material.dart';
import 'package:app_haircut/data.dart';
import 'package:app_haircut/registro_organizacao.dart';
import 'package:flutter/services.dart';

class LoginOrganizacao extends StatelessWidget {
  LoginOrganizacao({super.key});
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Organização'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: cnpjController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CNPJ',
                  hintText: 'XX.XXX.XXX/0001-XX',
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(14),
                  CnpjMaskTextInputFormatter(),
                ],





              ),
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String cnpj = cnpjController.text;
                  String senha = senhaController.text;

                  if (cnpj.isNotEmpty && senha.isNotEmpty) {
                    bool loggedIn = await loginOrganizacao(cnpj, senha);

                    if (loggedIn) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Gerenciamento()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('CNPJ ou senha incorretos'),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('CNPJ e senha são obrigatórios'),
                      ),
                    );
                  }
                },
                child: const Text('Fazer Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
