import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:my_perform/accueil_connect.dart';
import 'package:my_perform/main.dart';

late bool isAuthenticated;

class UserData {
  final String date;
  final String time;
  //Reste depuis la BDD
  final String email;
  final String password;
  final String lastName;
  final String firstName;
  final String companyName;
  final String adresseComplete;
  final String nameFormule;
  final String descriptionFormule;
  final String htPrice;
  final String ttcPrice;
  final bool renewal;
  final String dateInvoice;
  final String startDate;
  final String endDate;
  final String linkPDF;

  UserData({
    required this.date,
    required this.time,
    //Reste depuis la BDD
    required this.email,
    required this.password,
    required this.lastName,
    required this.firstName,
    required this.companyName,
    required this.adresseComplete,
    required this.nameFormule,
    required this.descriptionFormule,
    required this.htPrice,
    required this.ttcPrice,
    required this.renewal,
    required this.dateInvoice,
    required this.startDate,
    required this.endDate,
    required this.linkPDF,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    final now = DateTime.now();
    final date = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}';
    final time = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    String getDescriptionFormule(String nameFormule) {
      switch (nameFormule) {
        case "DUER":
          return "Formule réservée aux TPE";
        case "Primo":
          return "1 Module au choix autre que le module action";
        case "Amélioration":
          return "1 Module au choix + module Action";
        case "Performance":
          return "Anomalie ou Risque, Signalement, Audit, Action";
        case "Prévention":
          return "Risque, Accident, Signalement, Échéance, Action";
        case "Excellence":
          return "Accès à tous les modules";
      }
      return "Une erreur est survenue,\nveuillez reessayer ulterieurement.";
    }
      
    UserData result = UserData(
      date: date,
      time: time,
      email: json['email'],
      password: json['password'],
      lastName: json['lastName'],
      firstName: json['firstName'],
      companyName: json['companyName'],
      adresseComplete: json['adresseComplete'],
      nameFormule: json['nameFormule'],
      descriptionFormule: getDescriptionFormule(json['nameFormule']),
      htPrice: json['htPrice'],
      ttcPrice: json['ttcPrice'],
      renewal: json['renewal'],
      dateInvoice: json['dateInvoice'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      linkPDF: json['linkPDF'],
    );
    return result;
  }
}

//connexion BDD (api / local)
Future<List<UserData>> readDatabase() async {
  final String data = await rootBundle.loadString('assets/bdd.json');
  final List<dynamic> jsonList = jsonDecode(data)['users'];
  return jsonList.map((json) => UserData.fromJson(json)).toList();
}

//Vérification paire identifiant:mdp
Future<bool> connectApi({required String email, required String password, required BuildContext context}) async {
  final List<UserData> users = await readDatabase();
  isAuthenticated = false;

  for (var user in users) {
    if (user.email == email && user.password == password) {
      redirection(context, user);
      return isAuthenticated = true;
    }
  }
  return isAuthenticated;
}

void redirection(BuildContext context, UserData user) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AccueilConnect(userData: user),
    ),
  );
}

void handleLogoutEnd(BuildContext context) {
  isAuthenticated = false;
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => MainApp()),
    (Route<dynamic> route) => false,
  );
}