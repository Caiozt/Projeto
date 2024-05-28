import 'package:flutter/material.dart';
import 'package:app_haircut/data.dart';

class Gerenciamento extends StatefulWidget {
  const Gerenciamento ({super.key});
  @override
  GerenciamentoState createState() => GerenciamentoState();
}

class GerenciamentoState extends State<Gerenciamento> {
  List<Map<String, dynamic>> recenteAgendamento = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos Recentes'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                fetchRecentAgendamentos((data) {
                  setState(() {
                    recenteAgendamento = data;
                  });
                });
              },
              child: const Text('Carregar Agendamentos Recentes'),
            ),
            const SizedBox(height: 20),
            if (recenteAgendamento.isEmpty)
              const Text('Pressione o botão para carregar os agendamentos recentes'),
            for (var agendamento in recenteAgendamento)
              Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('ID de Agendamento: ${agendamento['id_agendamento']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID de Usuário: ${agendamento['id_usuario']}'),
                      Text('CPF: ${agendamento['cpf']}'),
                      Text('Nome: ${agendamento['nomeU']}'),
                      Text('Horário: ${agendamento['horario']}'), // Adicionando horário
                      Text('Dia: ${agendamento['dia']}'), // Adicionando dia
                      // Don't display senhaU
                    ],
                  ),
                ),
              ),
          ],
        ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Gerenciamento(),
  ));
}