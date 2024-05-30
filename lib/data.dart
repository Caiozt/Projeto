import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

Future<void> sendUserData(Map<String, String> userData) async {
  var url = 'https://4e09-2804-14c-51-a70d-d97-d49a-80d-94de.ngrok-free.app';
  var headers = {'Content-Type': 'application/json'};
  
  var response = await http.post(Uri.parse(url), body: jsonEncode(userData), headers: headers);
  var logger = Logger();

  if (response.statusCode == 201) {
    logger.i('Dados do usuário enviados com sucesso');
  } else {
    logger.e('Erro ao enviar dados do usuário para o servidor');
    logger.e('Código de status: ${response.statusCode}');
  }
}

Future<void> sendOrganizationData(Map<String, String> organizationData) async {
  var url = 'https://4e09-2804-14c-51-a70d-d97-d49a-80d-94de.ngrok-free.app'; 
  var headers = {'Content-Type': 'application/json'};
  
  var response = await http.post(Uri.parse(url), body: jsonEncode(organizationData), headers: headers);
  var logger = Logger();

  if (response.statusCode == 201) {
    logger.i('Dados da organização enviados com sucesso');
  } else {
    logger.e('Erro ao enviar dados da organização para o servidor');
    logger.e('Código de status: ${response.statusCode}');
  }
}

Future<bool> loginUsuario(String cpf, String senhaU) async {
  var url = 'https://4e09-2804-14c-51-a70d-d97-d49a-80d-94de.ngrok-free.app';
  var headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({'login_usuario': {'cpf': cpf, 'senhaU': senhaU}});

  var response = await http.post(Uri.parse(url), body: body, headers: headers);
  var logger = Logger();

  if (response.statusCode == 200) {
    logger.i('Login de usuário realizado com sucesso');
    return true;
  } else {
    logger.e('Erro ao realizar login de usuário');
    logger.e('Código de status: ${response.statusCode}');
    return false;
  }
}

Future<bool> loginOrganizacao(String cnpj, String senha) async {
  var url = 'https://4e09-2804-14c-51-a70d-d97-d49a-80d-94de.ngrok-free.app'; 
  var headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({'login_organizacao':{'cnpj': cnpj, 'senha_organizacao': senha}});

  var response = await http.post(Uri.parse(url), body: body, headers: headers);
  var logger = Logger();

  if (response.statusCode == 200) {
    logger.i('Login de organização realizado com sucesso');
    return true;
  } else {
    logger.e('Erro ao realizar login de organização');
    logger.e('Código de status: ${response.statusCode}');
    return false;
  }
}

Future<bool> enviarAgendamento(TimeOfDay _horarioSelecionado, DateTime _diaSelecionado) async {
  var url = 'https://4e09-2804-14c-51-a70d-d97-d49a-80d-94de.ngrok-free.app';
  var headers = {'Content-Type': 'application/json'};
  var body = jsonEncode({'agendamento':{'horario': '${_horarioSelecionado.hour.toString().padLeft(2, '0')}:${_horarioSelecionado.minute.toString().padLeft(2, '0')}', 'dia': _diaSelecionado.toIso8601String().substring(0, 10)}});

  try {
    var response = await http.post(Uri.parse(url), body: body, headers: headers);
    var logger = Logger();

    if (response.statusCode == 200) {
      logger.i('Agendamento realizado com sucesso');
      return true;
    } else {
      logger.e('Erro ao realizar agendamento');
      logger.e('Código de status: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('Erro ao enviar agendamento: $e');
    return false;
  }
}

Future<void> fetchRecentAgendamentos(Function(List<Map<String, dynamic>>) callback) async {
  try {
    final url = 'https://4e09-2804-14c-51-a70d-d97-d49a-80d-94de.ngrok-free.app';
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Map<String, dynamic>> appointments = List<Map<String, dynamic>>.from(data);
      callback(appointments);
    } else {
      throw Exception('Erro no load dos agendamentos');
    }
  } catch (e) {
    print('Erro recebendo agendamento recente: $e');
  }
}
