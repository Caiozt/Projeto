import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Hair Cut';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
   void navigateToRegistrationUserPage() {
    //manda para a página de registro do usuário
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationUserPage()),
    );
  }

  void navigateToLoginUserPage() {
    //manda para a página de login do usuário
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginUserPage()),
    );
  }

  void navigateToRegistrationOrganizationPage() {
    //manda para a página de registro da organização
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationOrganizationPage()),
    );
  }

  void navigateToLoginOrganizationPage() {
    //manda para a página de login da organização
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginOrganizationPage()),
    );
  }


   
  void navigateToMyHomePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage()),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hair Cut',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff0e06f7),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(60),
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: navigateToRegistrationUserPage,
                child: const Text('Registrar como Usuário'),
              ), //registrar como Usuario
              const SizedBox(
                height: 20,
              ), //espaço
              ElevatedButton(
                onPressed: navigateToLoginUserPage,
                child: const Text('Login como Usuário'),
              ), //login como usuario
              const SizedBox(
                height: 20,
              ), //espaço
              ElevatedButton(
                onPressed: navigateToRegistrationOrganizationPage,
                child: const Text('Registrar como Organização'),
              ), //registrar como organização
              const SizedBox(
                height: 20,
              ), // espaço
              ElevatedButton(
                onPressed: navigateToLoginOrganizationPage,
                child: const Text('Login como Organização'),
              ), // login como organização
            ],
          ),
        ),
      ),
    );
  }
}




//registro do usuário

class RegistrationUserPage extends StatelessWidget {
  RegistrationUserPage({super.key});
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
                _CpfMaskTextInputFormatter(),
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




//caixa de texto do cpf
class _CpfMaskTextInputFormatter extends TextInputFormatter {
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


//Login do cliente

class LoginUserPage extends StatelessWidget {
  const LoginUserPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login como Usuário'),
      ),
      body: const Center(
        child: Text('Página de login de usuário'),
      ),
    );
  }
}


Future<void> sendUserData(Map<String, String> userData) async {
  var url = 'https://bdb7-2804-14c-51-a70d-c0e3-78d4-95b3-37b3.ngrok-free.app'; //substitui a url aqui
  var headers = {'Content-Type': 'application/json'};
  
  //envia a solicitação POST com os dados da organização para o servidor
  var response = await http.post(Uri.parse(url), body: jsonEncode(userData), headers: headers);
  var logger = Logger();

  if (response.statusCode == 200) {
    logger.i('Dados do usuario enviados com sucesso');
  } else {
    logger.e('Erro ao enviar dados do usuario para o servidor');
    logger.e('Código de status: ${response.statusCode}');
  }
}






//Registro da empresa

class RegistrationOrganizationPage extends StatelessWidget {
  RegistrationOrganizationPage({super.key});
  final TextEditingController  cnpjController = TextEditingController();
  final TextEditingController  nomeController = TextEditingController();
  final TextEditingController  senhaController = TextEditingController();

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
                _CnpjMaskTextInputFormatter(),
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
                  "nome_organização": nomeController.text,
                  "senha_organização": senhaController.text,
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

//caixa de texto do cnpj
class _CnpjMaskTextInputFormatter extends TextInputFormatter {
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


//login da organização
class LoginOrganizationPage extends StatelessWidget {
   const LoginOrganizationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login como Organização'),
      ),
      body: const Center(
        child: Text('Página de login de organização'),
      ),
    );
  }
}


//mandando informação pro servidor local com o host de servidor 
Future<void> sendOrganizationData(Map<String, String> organizationData) async {
  var url = 'https://bdb7-2804-14c-51-a70d-c0e3-78d4-95b3-37b3.ngrok-free.app'; // substitui pela url aqui tbm
  var headers = {'Content-Type': 'application/json'};
  
  var response = await http.post(Uri.parse(url), body: jsonEncode(organizationData), headers: headers);
  var logger = Logger();

  if (response.statusCode == 200) {
    logger.i('Dados da organização enviados com sucesso');
  } else {
    logger.e('Erro ao enviar dados da organização para o servidor');
    logger.e('Código de status: ${response.statusCode}');
  }
}

