import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Hair Cut';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        // useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state.
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
   void navigateToRegistrationUserPage() {
    // Navigate to the registration page for users
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationUserPage()),
    );
  }

  void navigateToLoginUserPage() {
    // Navigate to the login page for users
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginUserPage()),
    );
  }

  void navigateToRegistrationOrganizationPage() {
    // Navigate to the registration page for organizations
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationOrganizationPage()),
    );
  }

  void navigateToLoginOrganizationPage() {
    // Navigate to the login page for organizations
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginOrganizationPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          'Hair Cut',
          style: TextStyle(
            color: Colors.white, // Cor da fonte
            fontSize: 30.0, // Tamanho da fonte
            fontWeight: FontWeight.bold, // Negrito
          ),
        ),
        backgroundColor: const Color(0xff0e06f7),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(60),
          color: Colors.blue,
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: navigateToRegistrationUserPage,
                child: const Text('Registrar como Usuário'),
              ), //registrar como Usuario
              const SizedBox(
                //Use of SizedBox
                height: 20,
              ), //espaço
              ElevatedButton(
                onPressed: navigateToLoginUserPage,
                child: const Text('Login como Usuário'),
              ), //login como usuario
              const SizedBox(
                //Use of SizedBox
                height: 20,
              ), //espaço
              ElevatedButton(
                onPressed: navigateToRegistrationOrganizationPage,
                child: const Text('Registrar como Organização'),
              ), //registrar como organização
              const SizedBox(
                //Use of SizedBox
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
class RegistrationUserPage extends StatelessWidget {
  const RegistrationUserPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro como Usuário'),
      ),
      body: const Center(
        child: Text('Página de registro de usuário'),
      ),
    );
  }
}

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