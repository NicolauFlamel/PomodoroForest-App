import 'package:flutter/material.dart';
import 'garden_service.dart';

class SettingsPage extends StatelessWidget {
  final GardenService _gardenService = GardenService();

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
        height: 300,
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
                // Implementar redefinir usuário
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Redefinir Senha',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                // Implementar redefinir senha
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Limpar Floresta',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              onTap: () {
                _deleteGarden(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _deleteGarden(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Limpar Floresta'),
          content: Text('Tem certeza que deseja realizar essa ação? (Essa ação não pode ser desfeita)'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Limpar'),
              onPressed: () {
                _gardenService.deleteGardenData(); 
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Floresta limpada com sucesso.'),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}