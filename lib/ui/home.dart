import 'package:first_flutter_app/util/hexColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'customButton.dart';

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("True Citzen"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        child: Column(

        ),
      ),
    );
  }
}


class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {

  int _tipPercentage = 0;
  int personCounter = 1;
  double billAmmount = 0.0;
  
  Color _purple = HexColor("#6908D6");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: _purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Total por pessoa", style: TextStyle(
                      color: _purple,
                      fontWeight: FontWeight.normal,
                      fontSize: 15.0
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("R\$ ${calculateTotal(billAmmount, personCounter, _tipPercentage)}", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34.9,
                        color: _purple
                      ),),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                  style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(
                      color: Colors.grey
                    ),
                    decoration: InputDecoration(
                      prefixText: "Total da Conta: ",
                      prefixIcon: Icon(Icons.attach_money)
                    ),
                    onChanged: (String value) {
                      try {
                        billAmmount = double.parse(value);
                      }catch(exception) {
                        billAmmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Dividir por:",
                        style: TextStyle(
                          color: Colors.grey.shade700
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if(personCounter > 1) {
                                  personCounter -= 1;
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: _purple.withOpacity(0.1)
                              ),
                              child: Center(
                                child: Text("-",
                                  style: TextStyle(
                                    color: _purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text("$personCounter", style: TextStyle(
                            color: _purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0
                          ),),
                          InkWell(
                            onTap: () {
                              setState(() {
                                personCounter +=1;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: _purple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(7.0)
                              ),
                              child: Center(
                                child: Text("+", style: TextStyle(
                                  color: _purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0
                                ),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Gorjeta", style: TextStyle(
                        color: Colors.grey.shade700
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("R\$ ${calculateTotalTip(billAmmount, personCounter, _tipPercentage)}", style: TextStyle(
                          color: _purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0
                        ),),
                      )
                    ],
                  ),
                  //Slider
                  Column(
                    children: <Widget>[
                      Text("$_tipPercentage%", style: TextStyle(
                        color: _purple,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold
                      ),),
                      Slider(
                        min: 0,
                        max: 100,
                        activeColor: _purple,
                        inactiveColor: Colors.grey,
                        divisions: 10,
                        value: _tipPercentage.toDouble(),
                        onChanged: (double value) {
                          setState(() {
                            _tipPercentage = value.round();
                          });
                        }
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String calculateTotal(double billAmount, int splitBy, int tipPercentage) {

    var totalPerPerson = (double.parse(calculateTotalTip(billAmount, splitBy, tipPercentage)) + billAmmount) / splitBy;

    return totalPerPerson.toStringAsFixed(2);

  }

  String calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;

    if(billAmmount < 0 || billAmmount.toString().isEmpty || billAmmount == null) {

    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip.toStringAsFixed(2);
  }
}

class Wisdom extends StatefulWidget {
  @override
  _WisdomState createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {

  int _index = 0;

  final List quotes = [
    "Spread love everywhere you go. Let no one ever come to you without leaving happier. -Mother Teresa",
    "When you reach the end of your rope, tie a knot in it and hang on. -Franklin D. Roosevelt",
    "Always remember that you are absolutely unique. Just like everyone else. -Margaret Mead",
    "Don't judge each day by the harvest you reap but by the seeds that you plant. -Robert Louis Stevenson",
    "The future belongs to those who believe in the beauty of their dreams. -Eleanor Roosevelt",
    "Tell me and I forget. Teach me and I remember. Involve me and I learn. -Benjamin Franklin",
    "The best and most beautiful things in the world cannot be seen or even touched - they must be felt with the heart. -Helen Keller",
    "It is during our darkest moments that we must focus to see the light. -Aristotle",
    "Whoever is happy will make others happy too. -Anne Frank",
    "Do not go where the path may lead, go instead where there is no path and leave a trail. -Ralph Waldo Emerson",
    "The greatest glory in living lies not in never falling, but in rising every time we fall. -Nelson Mandela",
    "The way to get started is to quit talking and begin doing. -Walt Disney",
    "Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma – which is living with the results of other people's thinking. -Steve Jobs",
    "If life were predictable it would cease to be life, and be without flavor. -Eleanor Roosevelt",
    "If you look at what you have in life, you'll always have more. If you look at what you don't have in life, you'll never have enough. -Oprah Winfrey",
    "If you set your goals ridiculously high and it's a failure, you will fail above everyone else's success. -James Cameron",
    "Life is what happens when you're busy making other plans. -John Lennon",
    "You will face many defeats in life, but never let yourself be defeated. -Maya Angelou",
    "The greatest glory in living lies not in never falling, but in rising every time we fall. -Nelson Mandela",
    "In the end, it's not the years in your life that count. It's the life in your years. -Abraham Lincoln",
    "Never let the fear of striking out keep you from playing the game. -Babe Ruth",
    "Life is either a daring adventure or nothing at all. -Helen Keller",
    "Many of life's failures are people who did not realize how close they were to success when they gave up. -Thomas A. Edison",
    "You have brains in your head. You have feet in your shoes. You can steer yourself any direction you choose. -Dr. Seuss",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Container(
                  width: 350,
                  height: 200,
                  margin: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(14.5)
                  ),
                  child: Center(
                      child: Text(
                        quotes[_index % quotes.length],
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                          fontSize: 16.5
                        ),
                      )
                  )
                ),
              ),
            ),
            Divider(thickness: 1.3,),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FlatButton.icon(
                  onPressed: _showQuote,
                  color: Colors.green,
                  icon: Icon(
                    Icons.wb_sunny,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Inspire me!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.8
                    ),
                  )
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  _showQuote() {
    setState(() {
      _index += 1;
    });
  }
}

class BizCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BizCard"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            _getCard(),
            _getAvatar()
          ],
        ),
      ),
    );
  }

  Container _getAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(color: Colors.redAccent, width: 1.2),
        image: DecorationImage(image: NetworkImage("https://picsum.photos/300"), fit: BoxFit.cover),
      ),
    );
  }

  Container _getCard() {
    return Container(
      width: 350,
      height: 200,
      margin: EdgeInsets.all(50.0),
      decoration: BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(14.5)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Osias Carneiro",
            style: TextStyle(
              fontSize: 20.9,
              fontWeight: FontWeight.normal,
              color: Colors.white
            ),
          ),
          Text("My First App"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person),
              Text("T: @oziaz")
            ],
          )
        ],
      ),
    );
  }
}

class ScaffoldExample extends StatelessWidget {

  _tapButton() {
    debugPrint("debug email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scaffold"),
        centerTitle: false,
        backgroundColor: Colors.amberAccent.shade100,
        actions: <Widget> [
          IconButton(icon: Icon(Icons.email), onPressed: () => debugPrint("debug email")),
          IconButton(icon: Icon(Icons.alarm), onPressed: () => debugPrint("debug email")),
          IconButton(icon: Icon(Icons.delete), onPressed: _tapButton)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        child: Icon(Icons.backup),
        onPressed: () => debugPrint("Hello FAB"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.beach_access), title: Text("first")),
          BottomNavigationBarItem(icon: Icon(Icons.accessibility), title: Text("second")),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), title: Text("third"))
        ],
        onTap: (int index) => debugPrint("Tapped item $index"),
      ),
      backgroundColor: Colors.redAccent,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            CustomButton()
          ],
        ),
      ),
    );
  }
}