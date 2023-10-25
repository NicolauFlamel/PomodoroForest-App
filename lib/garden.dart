import 'package:flutter/material.dart';
import 'garden_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class GardenScreen extends StatefulWidget {
  @override
  _GardenScreenState createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  final GardenService _gardenService = GardenService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Visão Geral'),
        backgroundColor: const Color.fromRGBO(81, 163, 135, 1),
      ),
      body: StreamBuilder(
        stream: _gardenService.getTrees(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); 
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data available');
          } else {
            List<QueryDocumentSnapshot> trees = snapshot.data as List<QueryDocumentSnapshot>;

           return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: trees.length,
              itemBuilder: (context, index) {
                final data = trees[index].data() as Map<String, dynamic>;

                return GestureDetector(
                  onTap: () {
                    // Implementar interação
                  },
                  child: PlantTile(
                    plant: Plant(
                      name: data['name'] ?? 'Unknown',
                      imageAsset: data['imageAsset'] ?? 'assets/default_tree.png',
                    ),
                  ),
                );
              },
            ); 
          }
        },
      ), 
    );
  }
}

class Plant {
  final String name;
  final String imageAsset;

  Plant({required this.name, required this.imageAsset});
}

class PlantTile extends StatelessWidget {
  final Plant plant;

  PlantTile({required this.plant});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            plant.imageAsset,
            width: 64.0,
            height: 64.0,
          ),
          SizedBox(height: 8.0),
          Text(plant.name),
        ],
      ),
    );
  }
}