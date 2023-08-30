import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class PDFViewerScreen extends StatelessWidget {
  final String linkPDF;
  final String dateInvoice;

  PDFViewerScreen({required this.linkPDF, required this.dateInvoice});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.orange,
      ),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFBF360C),
                  Color.fromARGB(255, 255, 141, 26),
                  Color(0xFFBF360C),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                transform: GradientRotation(45),
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Facture du $dateInvoice',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
        body: Center(
          child: FutureBuilder<SfPdfViewer>(
            future: loadPdf(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Si la connexion est en attente, afficher un indicateur de chargement
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.orange)),
                    SizedBox(height: 20.0),
                    Text(
                      "Vérification de sécurité en cours",
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                // Si une erreur s'est produite, afficher une boîte de dialogue d'erreur
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showErrorDialog(context, snapshot.error.toString());
                });
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/triste.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Une erreur est survenue,\nveuillez reessayer ulterieurement.",
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else {
                // Si tout est en ordre, afficher le PDF
                return snapshot.data!;
              }
            },
          ),
        ),
      ),
    );
  }

  Future<SfPdfViewer> loadPdf() async {
    // Vérifier la connexion Internet
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw "Veuillez vérifiez votre connexion Internet et réessayez.";
    }

    try {
      // Téléchargement et affichage du PDF
      final response = await http.get(Uri.parse(linkPDF));
      if (response.statusCode != 200) {
        throw 'Une erreur est survenue lors du téléchargement du PDF.\n\nCode d\'état: ${response.statusCode}.';
      }
      final bytes = response.bodyBytes;
      return SfPdfViewer.memory(bytes);
    } catch (e) {
      throw 'Une erreur est survenue lors du chargement du PDF.\n\n$e';
    }
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    // Afficher une boîte de dialogue d'erreur personnalisée
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
                      child: Text('Visualisation annulé'),
                    )
                  ],
                ),
          content: Text(errorMessage),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}