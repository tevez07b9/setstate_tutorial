import 'package:flutter/material.dart';
import 'package:setstate_tutorial/constants.dart';
import 'package:setstate_tutorial/drinks_widget.dart';
import 'package:setstate_tutorial/models/drink.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter State Management',
      home: DemoApp(),
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  List<Drink> drinks = [
    Drink("Water", false),
    Drink("Green Apple", false),
    Drink("Swirl", false),
    Drink("Mango Slush", false),
  ];

  @override
  Widget build(BuildContext context) {
    var selectedDrinks = drinks.where((element) => element.selected);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Drinks Order"),
      ),
      body: Container(
        decoration: kMainBackgroundImage,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: kWhiteBackground,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Drinks tonight",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  ...drinks
                      .map((drink) => DrinksWidget(
                          drink: drink,
                          onChanged: (value) {
                            setState(() {
                              drink.selected =
                                  (value == null || !value) ? false : true;
                            });
                          }))
                      .toList(),
                  Text(
                    "The order is: ",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title: Text(selectedDrinks.toList()[index].name),
                      ),
                      itemCount: selectedDrinks.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
