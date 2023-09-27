import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], 
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: const Color.fromRGBO(81, 163, 135, 1),
        title: Text('Configurações'), 
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close), 
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
      ),
      body: Container(
        width: 400,
        height: 230,
        margin: EdgeInsets.all(16.0), 
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(16.0), 
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.person, size: 24), 
                  SizedBox(width: 8), 
                  Text(
                    'Conta',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(),
            ListTile(
              title: Text(
                'Redefinir Nome de Usuário',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                // Navigate to the change username screen (not implemented here)
              },
            ),
            Divider(), 
            ListTile(
              title: Text(
                'Redefinir Senha',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                // implementar
              },
            ),
          ],
        ),
      ),
    );
  }
}