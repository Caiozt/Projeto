import 'package:flutter/material.dart';
import 'package:app_haircut/registro_usuario.dart';
import 'package:app_haircut/registro_organizacao.dart';
import 'package:app_haircut/login_usuario.dart';
import 'package:app_haircut/login_organizacao.dart';

void main() {
  runApp(const MyApp());
}

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
  void navegarRegistrarUsuario() {
    //manda para a página de registro do usuário
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistroUsuario()),
    );
  }
  

  void navegarLoginUsuario() {
    //manda para a página de login do usuário
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginUsuario()),
    );
  }



  void navegarRegistrarOrganizacao() {
    //manda para a página de registro da organização
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistroOrganizacao()),
    );
  }

  void navegarLoginOrganizacao() {
    //manda para a página de login da organização
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginOrganizacao()),
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
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 175, 6, 247),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(82),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("imagens/cabeleiro_mainpage1.jpg"),
              fit: BoxFit.cover,
              ),
              ),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              ElevatedButton(
                onPressed: navegarRegistrarUsuario,
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color.fromARGB(255, 104, 104, 104), width: 2), 
                  ),
                child: const Text('Registrar como Usuário', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              ), //registrar como Usuario
              const SizedBox(
                height: 20,
              ), //espaço

              ElevatedButton(
                onPressed: navegarLoginUsuario,
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color.fromARGB(255, 104, 104, 104), width: 2), 
                  ),
                child: const Text('Login como Usuário', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              ), //login como usuario




              const SizedBox(
                height: 20,
              ), //espaço
              ElevatedButton(
                onPressed: navegarRegistrarOrganizacao,
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color.fromARGB(255, 104, 104, 104), width: 2), 
                  ),
                child: const Text('Registrar como Organização', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              ), //registrar como organização
              const SizedBox(
                height: 20,
              ), // espaço





              ElevatedButton(
                onPressed: navegarLoginOrganizacao,
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color.fromARGB(255, 104, 104, 104), width: 2), 
                  ),
                child: const Text('Login como Organização', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
              ), // login como organização





            ],
          ),
        ),
      ),
    );
  }
}

