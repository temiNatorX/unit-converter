import 'package:flutter/material.dart';

class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({super.key});

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  String selectedCategory = 'Length';
  String selectedUnit = 'Meters to Kilometers';
  final TextEditingController inputController = TextEditingController();
  String result = 'Result:';

  // Categories and their corresponding units
  final Map<String, List<String>> unitsMap = {
    'Length': ['Meters to Kilometers', 'Kilometers to Meters', 'Inches to Feet', 'Feet to Inches'],
    'Weight': ['Kilograms to Pounds', 'Pounds to Kilograms', 'Pounds to Ounces', 'Ounces to Pounds'],
    'Temperature': ['Celsius to Kelvin', 'Kelvin to Celsius', 'Celsius to Fahrenheit', 'Fahrenheit to Celsius'],
    'Volume': ['Liters to Gallons', 'Gallons to Liters', 'Milliliters to Fluid Ounces', 'Fluid Ounces to Milliliters'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine whether the screen is wide enough (desktop or large tablet)
          bool isWideScreen = constraints.maxWidth > 600;
          double fieldWidth = isWideScreen ? constraints.maxWidth * 0.6 : constraints.maxWidth * 0.8;

          return Container(
            color: Colors.lightBlue[50], // Set the background color here
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: fieldWidth,
                    child: DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Select Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0), // Rounded borders
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: unitsMap.keys.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                          selectedUnit = unitsMap[selectedCategory]![0];
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: fieldWidth,
                    child: DropdownButtonFormField<String>(
                      value: selectedUnit,
                      decoration: InputDecoration(
                        labelText: 'Select Unit',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: unitsMap[selectedCategory]!.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedUnit = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: fieldWidth,
                    child: TextField(
                      controller: inputController,
                      decoration: InputDecoration(
                        labelText: 'Enter value',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      double? value = double.tryParse(inputController.text);
                      if (value != null) {
                        setState(() {
                          result = "Result: ${convertUnits(value, selectedCategory, selectedUnit)}";
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter a valid number')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(213, 91, 149, 250),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: const Text(
                      'Convert',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  result,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  double convertUnits(double value, String category, String unit) {
    switch (category) {
      case 'Length':
        switch (unit) {
          case 'Meters to Kilometers':
            return value / 1000;
          case 'Kilometers to Meters':
            return value * 1000;
          case 'Inches to Feet':
            return value / 12;
          case 'Feet to Inches':
            return value * 12;
        }
        break;
      case 'Weight':
        switch (unit) {
          case 'Kilograms to Pounds':
            return value * 2.20462;
          case 'Pounds to Kilograms':
            return value / 2.20462;
          case 'Pounds to Ounces':
            return value * 16;
          case 'Ounces to Pounds':
            return value / 16;
        }
        break;
      case 'Temperature':
        switch (unit) {
          case 'Celsius to Kelvin':
            return value + 273.15;
          case 'Kelvin to Celsius':
            return value - 273.15;
          case 'Celsius to Fahrenheit':
            return value * 9 / 5 + 32;
          case 'Fahrenheit to Celsius':
            return (value - 32) * 5 / 9;
        }
        break;
      case 'Volume':
        switch (unit) {
          case 'Liters to Gallons':
            return value / 3.78541;
          case 'Gallons to Liters':
            return value * 3.78541;
          case 'Milliliters to Fluid Ounces':
            return value / 29.5735;
          case 'Fluid Ounces to Milliliters':
            return value * 29.5735;
        }
        break;
    }
    return value;
  }
}
