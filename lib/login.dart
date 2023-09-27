import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(81, 163, 135, 1),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 2.0,
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;
    print('Username: $username');
    print('Password: $password');
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Usuário',
              enabledBorder: _inputBorder(),
              focusedBorder: _inputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Senha',
              enabledBorder: _inputBorder(),
              focusedBorder: _inputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => _handleLogin(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(81, 163, 135, 1),
            ),
            child: Text('Login'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(81, 163, 135, 1),
            ),
            child: Text('Não possui uma conta? Cadastre-se'),
          )
        ],
      ),
    );
  }
}