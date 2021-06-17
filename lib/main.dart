import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _numberFrom;
  String _startMeasure;
  String _convertedMeasure;
  String _resultMessage;

  //Create List for DropdownMenu
  final List<String> _measure = [
    'meters',
    'kilometers',
    'gram',
    'kilogram',
    'feet',
    'miles',
    'pounds(lbs)'
        'ounces'
  ];

  final Map<String, int> _measuresMap = {   //Crate map for logic with key pairs
    'meters' : 0,   //meters is key and 0 is value
    'kilometers' : 1,
    'grams' : 2,
    'kilograms' : 3,
    'feet' : 4,
    'miles' : 5,
    'pounds (lbs)' : 6,
    'ounces' : 7,
  };
  final dynamic _formulas = {  // this map contain formulas like 1 meter = 0.001 kilometer like this
    '0':[1,0.001,0,0,3.28084,0.000621371,0,0],
    '1':[1000,1,0,0,3280.84,0.621371,0,0],
    '2':[0,0,1,0.0001,0,0,0.00220462,0.035274],
    '3':[0,0,1000,1,0,0,2.20462,35.274],
    '4':[0.3048,0.0003048,0,0,1,0.000189394,0,0],
    '5':[1609.34, 1.60934,0,0,5280,1,0,0],
    '6':[0,0,453.592,0.453592,0,0,1,16],
    '7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
  };

  //value = _numberFrom, from = _startMeasure, to = _convertedMeasure
  void convert(double value, String from, String to) {
    int nFrom = _measuresMap[from];
    int nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];  //toString return an integer
    var result = value * multiplier;

    /* Dry run of above logic
    nFrom you find number associated with from means _startMeasure
    same as nTo you find number associated with to means _convertedMeasure
    */

    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    }
    else {
      _resultMessage = '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });

  }



  //This style is same for all inputStyle
  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.amber[900],
    fontWeight: FontWeight.bold,

  );

  //Once you created that's all same for all other labelStyle.
  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
    fontWeight: FontWeight.bold,
  );
  @override
  void initState(){
    _numberFrom = 0;
    super.initState();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      title: "Measure Converter",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Measures Converter"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Spacer(),
                SizedBox(height: 30,),
               Text(
                 "Value",
                 style: TextStyle(
                   fontSize: 24,
                   fontWeight: FontWeight.bold,
                   color: Colors.amber,
                 ),
               ),
                TextField(
                  style: inputStyle,
                  decoration: InputDecoration(
                      hintText: "Insert Measure To Be Converted",
                  ),
                  onChanged: (text){
                    var rv = double.tryParse(text); //return null for invalid instead of throwing this is double type
                    if(rv != null){
                      setState(() {
                        _numberFrom = rv; //this _numberFrom is which we input
                      });
                    }
                  },
                ),
                SizedBox(height: 50,),
                Text(
                  "From",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(height: 30,),
                DropdownButton(
                  items: _measure.map((String value){
                    return DropdownMenuItem<String>(
                      value:value,
                      child:Text(
                        value,
                        style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15.0,
                        decorationColor: Colors.blue,
                        ),
                      ),
                    );
                  }).toList(),  //.toList convert into List

                  onChanged: (value){
                    setState(() {
                      _startMeasure = value; //_startMeasure value changed after selected any of in DropdownMenuItem
                    });
                  },
                  value: _startMeasure,
                ),
                SizedBox(height: 50,),
                Text(
                  "To",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.amber,
                  ),
                ),
                SizedBox(height: 30,),
                DropdownButton(
                  items: _measure.map((String value){
                    return DropdownMenuItem<String>
                      (value:value,
                      child:Text(
                        value,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 15.0,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value){
                    setState(() {
                      _convertedMeasure = value;  //_convertedMeasure after selected any of in DropdownMenuItem
                    });
                  },
                  value: _convertedMeasure,
                ),
               SizedBox(height: 50,),
                RaisedButton(
                  child: Text(
                      "Convert",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )
                  ),
                  onPressed: () {
                    if (_startMeasure.isEmpty || _convertedMeasure.isEmpty ||
                        _numberFrom==0) {
                      return;
                    }
                    else {
                      convert(_numberFrom, _startMeasure, _convertedMeasure);
                    }
                  },
                ),
                SizedBox(height: 40,),
                Text((_resultMessage == null) ? '' : _resultMessage,
                    style: labelStyle),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

