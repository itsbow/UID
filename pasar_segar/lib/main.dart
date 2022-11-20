import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyD9BCDWWbq_IePIO5UdwUhQjIRJaKQduJI",
          appId: "com.example.pasar_segar",
          messagingSenderId: "",
          projectId: "pagar-7d3af"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass = TextEditingController();

    Future signin() async {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email.text, password: pass.text)
            .then((value) => {
                  print("Login succed"),
                  print(value.user!.email),
                  showAlertDialog(
                      context, "Login Success", value.user!.email as String)
                });
      } catch (e) {
        print(e);
        showAlertDialog(context, "Error", e.toString());
      }
    }

    Future signup() async {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: pass.text)
            .then((value) => {
                  print("Akun berhasil dibuat"),
                  print(value.user!.email),
                  showAlertDialog(
                      context, "Account Created", value.user!.email as String)
                });
      } catch (e) {
        print(e);
        showAlertDialog(context, "Error", e.toString());
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(children: [
            TextField(
              controller: email,
              decoration: InputDecoration(label: Text("Email")),
            ),
            TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(label: Text("Password")),
            ),
            ElevatedButton(
              onPressed: signin,
              child: Text("Login"),
            ),
            ElevatedButton(onPressed: signup, child: Text("SignUp")),
          ]),
        ));
  }
}

showAlertDialog(BuildContext context, String content, String email) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(content),
    content: Text("Email : " + email),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
