import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_perform/mentions_legales_page.dart';
import 'package:my_perform/apibdd.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyPerform',
      home: AuthScreen(
        emailController: emailController,
        passController: passController,
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passController;

  const AuthScreen({
    Key? key,
    required this.emailController,
    required this.passController,
  }) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _showEmailError = false;
  bool _showPasswordError = false;
  bool isAuthenticated = false;
  bool _isObscured = true;

  void _updateErrors() async {
    setState(() {
      _showEmailError = !_formKey.currentState!.validate();
      _showPasswordError = !_formKey.currentState!.validate();
    });

    if (!_showEmailError && !_showPasswordError) {
      bool isAuthenticated = await connectApi(
        email: widget.emailController.text,
        password: widget.passController.text,
        context: context,
      );
      if (isAuthenticated) {
        debugPrint('Login successful');
        widget.emailController.clear();
        widget.passController.clear();
        return;
      } else {
        debugPrint('Login failed');
        widget.passController.clear();
        Vibration.vibrate(duration: 50);
        showInvalidCredentialsDialog(context);
      }
    } else {
      Vibration.vibrate(duration: 50);
    }
  }
  
  void showInvalidCredentialsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
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
                child: Text('Erreur d\'identification'),
              )
            ],
          ),
          content: const Text(
              'Désolé, votre adresse e-mail et/ou mot de passe est incorrect.'),
          actions: <Widget>[
            TextButton(
              child: const Text('D\'accord'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // This line prevents the back action
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
        title: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/ic_launcher.png',
                  height: 50,
                ),
              ],
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Accueil',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(242, 242, 242, 1.0),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Bienvenue sur",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "MyPerform",
                  style: TextStyle(
                      fontSize: 47.5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RalewayBold',
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  height: 75,
                  width: 325,
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: widget.emailController,
                      decoration: const InputDecoration(
                        labelText: "Adresse e-mail",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Veuillez entrer une adresse e-mail valide";
                        }

                        if (!RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                            .hasMatch(value!)) {
                          return "Veuillez entrer une adresse e-mail valide";
                        }

                        return null;
                      },
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 75,
                  width: 325,
                  child: TextFormField(
                    focusNode: _passwordFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    controller: widget.passController,
                    obscureText: _isObscured,
                    decoration: InputDecoration(
                      labelText: "Mot de passe",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                        child: Icon(
                          _isObscured ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Veuillez entrer un mot de passe valide";
                      }
                      return null;
                    },
                    onEditingComplete: () {
                      _updateErrors();
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    _updateErrors();
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFBF360C),
                          Color.fromARGB(255, 255, 141, 26),
                          Color(0xFFBF360C),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        transform: GradientRotation(45),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "SE CONNECTER",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Vous n'avez pas de compte ?",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            late Uri url = Uri.parse(
                                'https://www.cogelis.com/');
                            if (!await launchUrl(url)) {
                              throw Exception(
                                  'Impossible de lancer $url : $Exception');
                            }
                          },
                          child: const Text(
                            "Inscrivez-vous",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
    ),);
  }
}