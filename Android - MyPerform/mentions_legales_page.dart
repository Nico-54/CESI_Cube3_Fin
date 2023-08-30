import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MentionsLegalesPage extends StatelessWidget {
  const MentionsLegalesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mentions Légales',
          style: TextStyle(fontSize: 18.0),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.account_circle,
              size: 30.0,
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(242, 242, 242, 1.0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Conditions d\'utilisation :',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Les présentes conditions d\'utilisation régissent l\'utilisation de l\'application mobile MyPerform. En accédant ou en utilisant notre application, vous acceptez d\'être lié par ces conditions. Veuillez lire attentivement les présentes conditions avant d\'utiliser l\'application. Si vous n\'acceptez pas ces conditions, veuillez ne pas utiliser l\'application.',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Politique de confidentialité :',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Notre politique de confidentialité vise à vous informer sur la manière dont nous collectons, utilisons, stockons et protégeons vos données personnelles lorsque vous utilisez notre application. Nous nous engageons à respecter la confidentialité et la sécurité de vos informations. Veuillez consulter notre politique de confidentialité pour en savoir plus sur nos pratiques en matière de confidentialité et sur vos droits en tant qu\'utilisateur.',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Mentions légales de l\'entreprise :',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'MyPerform est une entreprise de [insérer la nature de l\'entreprise] enregistrée auprès des autorités compétentes. Siège social : [adresse du siège social]. Numéro d\'identification fiscale : [numéro d\'identification fiscale]. Pour toute question ou demande concernant notre entreprise, veuillez nous contacter à [adresse e-mail de contact].',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Propriété intellectuelle :',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Tous les droits de propriété intellectuelle liés à l\'application MyPerform, y compris les droits d\'auteur, les marques de commerce et les brevets, sont réservés. L\'utilisation de notre application ne vous confère aucun droit de propriété intellectuelle sur son contenu ou ses fonctionnalités, sauf indication contraire expresse.',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Limitation de responsabilité :',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Nous nous efforçons de fournir une application précise et fiable, mais nous ne pouvons garantir son exactitude, son exhaustivité ou son adéquation à un usage particulier. En utilisant l\'application MyPerform, vous acceptez que nous ne soyons pas responsables des erreurs, des interruptions, des dommages matériels ou immatériels, des virus informatiques ou de tout autre problème résultant de l\'utilisation de notre application.',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
          ],
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
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Row(
                        children: [
                          Image.asset('assets/images/linkedin.png', height: 50,),
                          SizedBox(width: 5),
                          Text("Linkedin Contact"),
                        ],
                      ),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Divider(
                              color: Colors.grey,
                              thickness: 1.0,
                            ),
                            SizedBox(height: 15),
                            Text('SPREDER Pierre', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),),
                            GestureDetector(
                              onTap: () async {
                                Uri url = Uri.parse('https://www.linkedin.com/in/spreder-pierre/');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              child: Text('Développeur Mobile',style: TextStyle(color: Colors.blue, decoration: TextDecoration.none,),),
                            ),
                            SizedBox(height: 25),
                            Text('VIGOGNE Sylvain', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),),
                            GestureDetector(
                              onTap: () async {
                                Uri url = Uri.parse('https://www.linkedin.com/in/sylvain-vigogne-a8a236228/');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              child: Text('Développeur Back-End',style: TextStyle(color: Colors.blue, decoration: TextDecoration.none,),),
                            ),
                            SizedBox(height: 25),
                            Text('LEIRITZ Nicolas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),),
                            GestureDetector(
                              onTap: () async {
                                Uri url = Uri.parse('https://www.linkedin.com/in/nicolas-leiritz/');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              child: Text('Développeur Web',style: TextStyle(color: Colors.blue, decoration: TextDecoration.none,),),
                            ),
                            SizedBox(height: 25),
                            Text('BERNAUER Guillaume', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),),
                            GestureDetector(
                              onTap: () async {
                                Uri url = Uri.parse('https://www.linkedin.com/in/guillaume-bernauer-126409240/');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              child: Text('Développeur Web',style: TextStyle(color: Colors.blue, decoration: TextDecoration.none,),),
                            ),
                            SizedBox(height: 15),
                            Divider(
                              color: Colors.grey,
                              thickness: 1.0,
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Fermer'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/linkedin.png', height: 25),
                  Text("Linkedin Contact"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
