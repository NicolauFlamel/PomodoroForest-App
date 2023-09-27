import 'package:flutter/material.dart';

int _coins = 0;

class ShopPage extends StatelessWidget {
  final List<ShopItem> items = [
    ShopItem(
      name: 'Birch Tree',
      imageAsset: 'assets/birch.png',
      price: 50,
    ),
    ShopItem(
      name: 'Pine Tree',
      imageAsset: 'assets/pine.png',
      price: 75,
    ),
    ShopItem(
      name: 'Special Tree',
      imageAsset: 'assets/figo.png',
      price: 100,
    ),
    // adicionar mais itens
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(81, 163, 135, 1),
        centerTitle: true,
        title: Text('Loja'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 8, right: 8),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.6),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/coin.webp',
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 10),
                Text('$_coins', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ]
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          crossAxisSpacing: 16.0, 
          mainAxisSpacing: 16.0, 
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ShopItemCard(item: item);
        },
      ),
    );
  }
}

class ShopItem {
  final String name;
  final String imageAsset;
  final int price;

  ShopItem({
    required this.name,
    required this.imageAsset,
    required this.price,
  });
}

class ShopItemCard extends StatelessWidget {
  final ShopItem item;

  ShopItemCard({required this.item});

   @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0), 
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              item.imageAsset,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8.0),
            Text(
              item.name,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.attach_money,
                  color: Colors.amber,
                ),
                Text(
                  '${item.price}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}