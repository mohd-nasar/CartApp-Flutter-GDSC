import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyCart(),
      child: MaterialApp(
        title: 'Cart App',
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class Product {
  String image;
  String name;
  int price;
  Product({required this.image, required this.name, required this.price});
}

class MyCart with ChangeNotifier {
  final List<Product> cartItems = [];

  List<Product> get items => cartItems;

  void addToCart(Product product) {
    cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item == product);
    notifyListeners();
  }

  int getTotalPrice() {
    int totalPrice = 0;
    for (Product item in cartItems) {
      totalPrice += item.price;
    }
    return totalPrice;
  }

  void emptyCart() {
    cartItems.clear();
    notifyListeners();
  }
  bool isInCart(Product product){
    return (cartItems.contains(product));
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> imageUrls = [
    'https://s3.india.com/wp-content/uploads/2023/12/Amazon-Deals-4.jpg',
    'https://www.reliancedigital.in/medias/Smartphone-Bonanza-544x306.jpg?context=bWFzdGVyfGltYWdlc3w3NzEwNnxpbWFnZS9qcGVnfGltYWdlcy9oYTkvaDU4LzEwMDQxODcwODc2NzAyLmpwZ3wyMTdjMjllMDk3NDAzZjNlOGM3MmNiMzI1ZGMxZDRlODZhYWEwOWQzNmEwMWM5NzhmMDk5MGQ3ZmZmMDVhMzBh',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img23/Laptops_Revamp/Laptop_Deals_770x350.png',
    'https://pbs.twimg.com/media/DuXj6VLVAAAU7fd.jpg'
  ];
  final List<Product> mobiles = [
    Product(image: 'assets/iphone12.png', name: 'iPhone !2', price: 499),
    Product(image: 'assets/samsungs23.png', name: 'Samsung s23', price: 449),
    Product(image: 'assets/oldstyle.png', name: 'Nokia Razr', price: 549)
  ];
  final List<Product> laptops = [
    Product(image: 'assets/lap1.png', name: 'HP Pavilion 14', price: 999),
    Product(image: 'assets/mackbook.png', name: 'Mackbook Pro 16', price: 1499)
  ];
  final List<Product> clothes = [];
  final List<Product> explore = [
    Product(image: 'assets/mouse.png', name: 'Mouse', price: 129),
    Product(image: 'assets/ups.png', name: 'UPS 2KWH', price: 199),
    Product(image: 'assets/ram.png', name: 'RAM 16 GB', price: 99),
    Product(image: 'assets/speaker.png', name: 'Speaker', price: 109),
    Product(image: 'assets/cpu.png', name: 'CPU 128 Bits', price: 1199)
  ];

  MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final myCartState = Provider.of<MyCart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 177, 199, 222),
        title: Text(
          'Cart App',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Image.network(
                      imageUrls[index],
                      width: screenWidth,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Mobiles",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: 380, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mobiles.length,
                itemBuilder: (context, index) {
                  Product mobile = mobiles[index];
                  return Container(
                    color: Color.fromRGBO(194, 235, 181, 1),
                    height: 699,
                    width: 180,
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.yellow,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Deals',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.asset(
                            mobile.image,
                            height: 100,
                            width: 80,
                          ),
                        ),
                        Center(
                          child: Text(
                            mobile.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          width: 180,
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Text(
                            'Special Price ₹ ${mobile.price.toString()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          height: 32,
                          width: 180,
                          child: ElevatedButton(
                            onPressed: () {
                              myCartState.addToCart(mobile);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lime,
                            ),
                            child: Text(myCartState.isInCart(mobile) ? 'Added ✅' : 'Add to Cart',),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Laptop Deals to Steal",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              color: Colors.white,
              height: 220, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: laptops.length,
                itemBuilder: (context, index) {
                  Product laptop = laptops[index];
                  return Container(
                    color: Color.fromRGBO(184, 210, 232, 1),
                    width: 220,
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.yellow,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Deals',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          child: Center(
                            child: Image.asset(
                              laptop.image,
                              width: 80,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            laptop.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          width: 220,
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Text(
                            'Special Price ₹ ${laptop.price.toString()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 220,
                          child: ElevatedButton(
                            onPressed: () {
                              myCartState.addToCart(laptop);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lime,
                            ),
                            child: Text(myCartState.isInCart(laptop) ? '✅ Added' : 'Add to Cart',),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Explore",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              color: Colors.white,
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: explore.length,
                itemBuilder: (context, index) {
                  Product product = explore[index];
                  return Container(
                    color: Color.fromRGBO(230, 221, 159, 1),
                    height: 250,
                    width: 180,
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          color: Colors.yellow,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Deals',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: double.infinity,
                          child: Image.asset(
                            product.image,
                            height: 100,
                            width: 80,
                          ),
                        ),
                        Center(
                          child: Text(
                            product.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          width: 180,
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Text(
                            'Special Price ₹ ${product.price.toString()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          height: 32,
                          width: 180,
                          child: ElevatedButton(
                            onPressed: () {
                              myCartState.addToCart(product);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lime,
                            ),
                            child: Text(myCartState.isInCart(product) ? 'Added ✅' : 'Add to Cart',),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final mycartState = Provider.of<MyCart>(context);
    final List cartItems = mycartState.cartItems;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 181, 211, 229),
            title: Text(
              'Cart App',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  Product product = cartItems[index];
                  return ListTile(
                    leading: Image.asset(product.image),
                    title:
                        Text('${product.name}\n₹ ${product.price.toString()}'),
                    trailing: IconButton(
                      onPressed: () {
                        mycartState.removeFromCart(product);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Summary',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              children: [
                const Text('     Cart Total'),
                SizedBox(
                  width: screenWidth - 203,
                ),
                Text('₹ ${mycartState.getTotalPrice()}')
              ],
            ),
            Row(
              children: [
                Text('     Total Tax'),
                SizedBox(
                  width: screenWidth - 200,
                ),
                Text('₹ ${20 * mycartState.getTotalPrice()}'),
              ],
            ),
            Row(
              children: [
                Text('     Discount'),
                SizedBox(
                  width: screenWidth - 200,
                ),
                Text('₹ 0'),
              ],
            ),
            Row(
              children: [
                const Text('     Delivery'),
                SizedBox(
                  width: screenWidth - 194,
                ),
                Text('₹ ${10000 * mycartState.getTotalPrice()}')
              ],
            ),
            Row(
              children: [
                const Text(
                  '     Grand Total',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: screenWidth - 220,
                ),
                Text('₹ ${10021 * mycartState.getTotalPrice()}')
              ],
            ),
            SizedBox(
                width: screenWidth,
                child: ElevatedButton(
                  onPressed: () {
                    mycartState.emptyCart();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 250, 207, 207)),
                  child: Text(
                      'Buy Now     ₹ ${10021 * mycartState.getTotalPrice()}',
                      style: TextStyle(color: Colors.black)),
                )),
            SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
