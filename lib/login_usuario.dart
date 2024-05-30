import 'package:flutter/material.dart';
import 'package:app_haircut/data.dart';
import 'package:app_haircut/calendario.dart';
import 'package:app_haircut/registro_usuario.dart';
import 'package:flutter/services.dart';

class LoginUsuario extends StatelessWidget {
  LoginUsuario({super.key});
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController senhaUController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Usuário'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: cpfController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  hintText: 'XXX.XXX.XXX-XX',
                ),
                inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
                CpfMaskTextInputFormatter(), 
              ],

              ),
              TextField(
                controller: senhaUController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String cpf = cpfController.text;
                  String senhaU = senhaUController.text;

                  if (cpf.isNotEmpty && senhaU.isNotEmpty) {
                    bool loggedIn = await loginUsuario(cpf, senhaU);

                    if (loggedIn) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Calendario()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('CPF ou senha incorretos'),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('CPF e senha são obrigatórios'),
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