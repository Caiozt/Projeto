import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:app_haircut/data.dart';
import 'package:app_haircut/login_usuario.dart';
import 'package:app_haircut/login_organizacao.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  CalendarioState createState() => CalendarioState();
}

class CalendarioState extends State<Calendario> {
  late DateTime _diaSelecionado;
  late DateTime _diaFocado;
  late CalendarFormat _calendarioFormato;
  late TimeOfDay _horarioSelecionado;

  @override
  void initState() {
    super.initState();
    _diaSelecionado = DateTime.now();
    _diaFocado = DateTime.now();
    _calendarioFormato = CalendarFormat.month;
    _horarioSelecionado = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendário'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _diaFocado,
              calendarFormat: _calendarioFormato,
              onFormatChanged: (formato) {
                setState(() {
                  _calendarioFormato = formato;
                });
              },
              onPageChanged: (diaFocado) {
                setState(() {
                  _diaFocado = diaFocado;
                });
              },
              selectedDayPredicate: (dia) {
                return isSameDay(_diaSelecionado, dia);
              },
              onDaySelected: (diaSelecionado, diaFocado) {
                setState(() {
                  _diaSelecionado = diaSelecionado;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Data Selecionada: ${_diaSelecionado.toString().substring(0, 10)} \nHorário Selecionado: ${_horarioSelecionado.hour.toString().padLeft(2, '0')}:${_horarioSelecionado.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginUsuario()),
                );
              },
              child: const Text('Login como Usuário'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginOrganizacao()),
                );
              },
              child: const Text('Login como Organização'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool success = await enviarAgendamento(_horarioSelecionado, _diaSelecionado);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success ? 'Agendamento realizado com sucesso' : 'Falha ao realizar o agendamento'),
                  ),
                );
              },
              child: const Text('Agendar'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? horarioSelecionado = await showTimePicker(
                  context: context,
                  initialTime: _horarioSelecionado,
                );
                if (horarioSelecionado != null) {
                  setState(() {
                    _horarioSelecionado = horarioSelecionado;
                  });
                }
              },
              child: const Text('Selecionar Hora'),
            ),
          ],
        ),
      ),
    );
  }
}
