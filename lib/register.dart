import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Key for the form state

  String? _emailError;
  String? _passwordError;

  Future<void> _handleRegistration(BuildContext context) async {
    // Reset errors when handling registration
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    if (_formKey.currentState?.validate() ?? false) {
      String email = _usernameController.text;
      String password = _passwordController.text;

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        Navigator.pushNamed(context, '/home');
      } catch (e) {
        print('Registration error: $e');
        if (e is FirebaseAuthException) {
          if (e.code == 'weak-password') {
            setState(() {
              _passwordError = 'Senha fraca, escolha uma senha mais forte.';
            });
          } else if (e.code == 'email-already-in-use') {
            setState(() {
              _emailError = 'E-mail já cadastrado, escolha outro e-mail.';
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(81, 163, 135, 1),
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16.0),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um e-mail válido.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma senha válida.';
                  } else if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _handleRegistration(context),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(81, 163, 135, 1),
                ),
                child: Text('Cadastrar-se'),
              ),
              SizedBox(height: 16.0),
              if (_emailError != null || _passwordError != null)
                Text(
                  _emailError ?? _passwordError ?? '',
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Já possui uma conta? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}