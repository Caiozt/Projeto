import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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
    // Navega para a página de registro do usuário
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationUserPage()),
    );
  }

  void navigateToLoginUserPage() {
    // Navega para a página de login do usuário
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginUserPage()),
    );
  }

  void navigateToRegistrationOrganizationPage() {
    // Navega para a página de registro da organização
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationOrganizationPage()),
    );
  }

  void navigateToLoginOrganizationPage() {
    // Navega para a página de login da organização
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginOrganizationPage()),
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
  const RegistrationUserPage({super.key});

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
                //adicionar os bgl do sql, n sei
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
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





//Registro da empresa

class RegistrationOrganizationPage extends StatelessWidget {
  const RegistrationOrganizationPage({super.key});

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
                // Implementar lógica de registro da empresa
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


//Login da organização
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
