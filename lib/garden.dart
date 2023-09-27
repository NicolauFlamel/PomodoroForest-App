import 'package:flutter/material.dart';

class GardenScreen extends StatefulWidget {
  @override
  _GardenScreenState createState() => _GardenScreenState();
}

class _GardenScreenState extends State<GardenScreen> {
  List<Plant> plants = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Floresta'),
        backgroundColor: const Color.fromRGBO(81, 163, 135, 1),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //implementar 
            },
            child: PlantTile(
              plant: plants[index],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            plants.add(Plant(name: 'New Plant', imageAsset: 'assets/tree.png'));
          });
        },
        child: Icon(Icons.add), backgroundColor: const Color.fromRGBO(81, 163, 135, 1),
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