import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_perform/apibdd.dart';
import 'package:my_perform/mentions_legales_page.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:my_perform/pdf_visu.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class AccueilConnect extends StatefulWidget {
  final UserData userData;

  const AccueilConnect({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  AccueilConnectState createState() => AccueilConnectState();
}

class AccueilConnectState extends State<AccueilConnect> {
  static Timer? _timer; // Timer rendu statique
  int _secondsLeft = 600; // 10 minutes * 60 secondes = 600 secondes
  String _timerText = "10:00"; // format initial

  @override
  void initState() {
    super.initState();
    startTimerSession();
  }

  @override
  void dispose() {
    cancelTimer(); 
    super.dispose();
  }

  void startTimerSession() {
    cancelTimer(); 

    setState(() {
      _timerText = formattedTime; 
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        cancelTimer();
        handleLogout(); 
      } else {
        setState(() {
          _secondsLeft--;
          _timerText = formattedTime;
          debugPrint(_timerText);
        });
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  String get formattedTime {
    int minutes = _secondsLeft ~/ 60;
    int seconds = _secondsLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  //Déclaration des controllers
  late TextEditingController nameController = TextEditingController(text: '${widget.userData.lastName.toUpperCase()} ${widget.userData.firstName}');
  late TextEditingController emailController = TextEditingController(text: widget.userData.email);
  late TextEditingController companyNameController = TextEditingController(text: widget.userData.companyName);
  late TextEditingController adresseCompleteController = TextEditingController(text: widget.userData.adresseComplete);
  late TextEditingController nameFormuleController = TextEditingController(text: widget.userData.nameFormule);
  late TextEditingController descriptionFormuleController = TextEditingController(text: widget.userData.descriptionFormule);
  late TextEditingController htPriceController = TextEditingController(text: widget.userData.htPrice);
  late TextEditingController ttcPriceController = TextEditingController(text: widget.userData.ttcPrice);
  late TextEditingController renewalController = TextEditingController(text: widget.userData.renewal ? '\u2705 Accepté' : '\u274C Refusé');
  late TextEditingController dateAbonnementController = TextEditingController(text: '${widget.userData.startDate} - ${widget.userData.endDate} (Inclus)');
  IconData currentIcon = Icons.file_download;

  void goTelecharger() async {
    String url = widget.userData.linkPDF;

    // Vérification de la connexion Internet
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/error.png',
                  height: 40,
                  width: 40,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text('Pas de connexion Internet'),
                )
              ],
            ),
            content: Text('Veuillez vérifiez votre connexion Internet et réessayez.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Arrêtez la suite du traitement si la connexion est absente
    }

    // Demande d'accès au stockage externe
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/error.png',
                  height: 40,
                  width: 40,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text('Accès au stockage refusé'),
                )
              ],
            ),
            content: Text('Veuillez autoriser l\'accès au stockage pour télécharger le fichier.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      setState(() {
        currentIcon = Icons.schedule_send;
      });

      String directoryPath = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
      Directory dir = Directory(directoryPath);
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }
      
      String modifiedDate = widget.userData.dateInvoice.replaceAll('/', '_');
      String baseFileName = 'MyPerform_Facture_Du_$modifiedDate';
      String fileExtension = '.pdf';
      String fileName = '$baseFileName$fileExtension';

      int counter = 1;
      while (await File('$directoryPath/$fileName').exists()) {
        fileName = '$baseFileName($counter)$fileExtension';
        counter++;
      }

      var client = http.Client();
      var request = await client.get(Uri.parse(url));

      if (request.statusCode == 200) {
        var bytes = request.bodyBytes;

        File file = File('$directoryPath/$fileName');
        await file.writeAsBytes(bytes);

        setState(() {
          currentIcon = Icons.file_download_done;
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/validate.png',
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text('Téléchargement réussi'),
                  )
                ],
              ),
              content: Text(
                  'Le téléchargement de votre dernière facture est terminée.\n\nNom du fichier: "$fileName"\n\nChemin d\'accès du fichier: $directoryPath'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          currentIcon = Icons.error;
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/error.png',
                    height: 40,
                    width: 40,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text('Téléchargement annulé'),
                  )
                ],
              ),
              content: Text(
                  'Une erreur est survenue pendant le téléchargement, veuillez reessayer ulterieurement.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
      client.close();
    } catch (e) {
      setState(() {
        currentIcon = Icons.error;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/error.png',
                      height: 40,
                      width: 40,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text('Téléchargement annulé'),
                    )
                  ],
                ),
            content: Text('Une erreur est survenue pendant le téléchargement, veuillez reessayer ulterieurement.\n\n$e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _refreshWrapper() async {
    return _handleRefresh(context);
  }

  Future<void> _handleRefresh(BuildContext context) async {
    try {
      List<UserData> users = await readDatabase();
      if (users.isNotEmpty) {
        UserData user = users.firstWhere(
          (u) => u.email == widget.userData.email,
        );
        redirection(context, user);
      }
    } catch (e) {
      handleLogoutEnd(context);
    }
  }

  void handleLogout() {
    handleLogoutEnd(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop(); // Ferme complètement l'application
          return false; // Empêche la navigation arrière
        },
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFBF360C),
                    Color.fromARGB(255, 255, 141, 26),  // légère modification de la couleur du milieu
                    Color(0xFFBF360C),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  transform: GradientRotation(45),
                ),
              ),
            ),
            title: Row(
              children: [
                Image.asset(
                  'assets/images/ic_launcher.png',
                  height: 50,
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Mon Compte',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: handleLogout,
              ),
            ],
          ),
        backgroundColor: const Color.fromRGBO(242, 242, 242, 1.0),
        body: RefreshIndicator(
          color: Colors.orange, // Couleur du cercle de rafraîchissement
          backgroundColor: Colors.white,
          onRefresh: _refreshWrapper,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Actualisé le ${widget.userData.date} à ${widget.userData.time}, session active: $_timerText",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
                //Partie Coordonnées
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: const TextSpan(
                        text: 'Coordonnées',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: nameController,
                      enabled: false,
                      style: TextStyle(
                        color: nameController.text.isNotEmpty
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : null,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Titulaire',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(225, 100, 20, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: emailController,
                      enabled: false,
                      style: TextStyle(
                        color: emailController.text.isNotEmpty
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : null,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Adresse e-mail',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(225, 100, 20, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                //Partie Société
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: const TextSpan(
                        text: 'Société',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: companyNameController,
                      enabled: false,
                      style: TextStyle(
                        color: nameController.text.isNotEmpty
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : null,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Nom de la société',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(225, 100, 20, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: AutoSizeTextField(
                      controller: adresseCompleteController,
                      enabled: false,
                      style: TextStyle(
                        color: nameController.text.isNotEmpty
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : null,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Adresse de la société',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(225, 100, 20, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      minFontSize: 12,
                      maxLines: null,
                    ),
                  ),
                ),
                //Partie Formule
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: const TextSpan(
                        text: 'Formule',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: nameFormuleController,
                      enabled: false,
                      style: TextStyle(
                        color: nameFormuleController.text.isNotEmpty
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : null,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Nom de la formule',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(225, 100, 20, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: AutoSizeTextField(
                      controller: descriptionFormuleController,
                      enabled: false,
                      style: TextStyle(
                        color: nameController.text.isNotEmpty
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : null,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Description de la formule',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(225, 100, 20, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      minFontSize: 12,
                      maxLines: null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: htPriceController,
                      enabled: false,
                      style: TextStyle(
                        color: htPriceController.text.isNotEmpty
                            ? const Color.fromARGB(255, 0, 0, 0)
                            : null,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Prix de la formule (Hors Taxes)',
                        labelStyle: TextStyle(
                          color: Color.fromRGBO(225, 100, 20, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: TextField(
                          controller: ttcPriceController,
                          enabled: false,
                          style: TextStyle(
                            color: ttcPriceController.text.isNotEmpty
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : null,
                          ),
                          decoration: const InputDecoration(
                            labelText:
                                'Prix de la formule (Toutes Taxes Comprises)*',
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(225, 100, 20, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2.5),
                      const Text(
                        '*La TVA peut varier selon les pays',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.5,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                //Partie Facturation
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: const TextSpan(
                        text: 'Facturation',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: TextField(
                          controller: renewalController,
                          enabled: false,
                          style: TextStyle(
                            color: renewalController.text.isNotEmpty
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : null,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Renouvellement automatique',
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(225, 100, 20, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: TextField(
                          controller: dateAbonnementController,
                          enabled: false,
                          style: TextStyle(
                            color: renewalController.text.isNotEmpty
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : null,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Date de validité l\'abonnement',
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(225, 100, 20, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // Couleur de fond du bloc
                    borderRadius:
                        BorderRadius.circular(2.0), // Border radius de 12
                    border: Border.all(
                      color: Colors.black, // Couleur de la bordure
                      width: 1.0, // Épaisseur de la bordure
                    ),
                  ),
                  padding:
                      const EdgeInsets.all(15.0), // Marge intérieure du bloc
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Text(
                          'Ma dernière facture',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Divider(
                        color: Colors.grey, // Couleur du séparateur
                        thickness: 1.0, // Épaisseur du séparateur
                      ),
                      const SizedBox(height: 8.0),
                      widget.userData.dateInvoice.isEmpty 
                        ? Center(
                            child: Text(
                              'Aucune facture disponible pour le moment',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Facture du ${widget.userData.dateInvoice}',
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${ttcPriceController.text}',
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Confirmation'),
                                            content: Text('Voulez-vous télécharger la facture ?'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('Annuler'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text('Confirmer'),
                                                onPressed: () {
                                                  goTelecharger();
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 7.5),
                                      child: Icon(currentIcon)  //arrow_circle_down_outlined en clair   //download_for_offline_sharp en gras
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PDFViewerScreen(linkPDF: widget.userData.linkPDF, dateInvoice: widget.userData.dateInvoice),
                                        ),
                                      );
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 7.5),
                                      child: Icon(Icons.visibility),//Avant
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                const SizedBox(height: 8),
                const Text(
                  "©2023 MyPerform | By Group B",
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MentionsLegalesPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Mentions Légales",
                  ),
                ),
              ],
            ),
          ),
        )
      );
  }
}
