// ignore: file_names
// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages, use_build_context_synchronously

import 'package:farmtastic/calculator/firebase.dart';
import 'package:flutter/material.dart';

import 'package:multiselect/multiselect.dart';
import 'package:fl_chart/fl_chart.dart';
import '../main/sidebar.dart';
import 'carbon_calc_base.dart';
import 'date_picker.dart';
import 'emission_his_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'emission_record_page.dart';

class CarbonCalculatorPage extends CarbonCalculatorBase {
  const CarbonCalculatorPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CarbonCalculatorPageState createState() => _CarbonCalculatorPageState();
}

class _CarbonCalculatorPageState
    extends CarbonCalculatorBaseState<CarbonCalculatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),

      appBar: AppBar(
        title:
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Text(
                'Carbon Footprint Calculator',
                style: TextStyle(
                  color: Color(0xFF567D01),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,

        backgroundColor: const Color(0xFFF9FFDF),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Color.fromARGB(255, 61, 88, 2),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.history,
              color: Color.fromARGB(255, 61, 88, 2),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EmissionHistoryPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 114, 165, 1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(bottom: 16.0),
                child: const Center(
                  child: Text(
                    'Welcome to quick Carbon Footprint Calculator',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmissionRecordPage(),
                    ),
                  );
                },
                color: const Color.fromARGB(255, 114, 165, 1),
                child: const Text(
                  'View Records',
                  style: TextStyle(
                    color: CupertinoColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 16.0),

              Card(
                elevation: 15.0,
                color: const Color.fromARGB(255, 233, 241, 195),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                    bottomLeft: Radius.circular(2.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8.0),
                      CupertinoButton(
                        onPressed: () async {
                          DateTime? selectedDate =
                              await DatePicker.showDatePickerModal(
                                  context, DateTime.now());
                          if (selectedDate != null) {
                            setState(() {
                              pickedDate = selectedDate;
                              buttonText =
                                  'Selected Date: ${DateFormat.yMd().format(pickedDate!)}';
                            });
                          }
                        },
                        color: const Color.fromARGB(255, 114, 165, 1),
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            color: CupertinoColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8.0),
                      // Input fields for water usage
                      TextField(
                        controller: waterUsageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Enter Water Usage (cubic meter)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      DropDownMultiSelect(
                        options: const [
                          'N fertilizer',
                          'P fertilizer',
                          'K fertilizer',
                          'Pesticides',
                          'Herbicide',
                        ],
                        selectedValues: selectedFertilizerTypes,
                        onChanged: (List<String> selectedItems) {
                          setState(() {
                            selectedFertilizerTypes = selectedItems;
                            fertilizerControllers.clear();
                            for (String type in selectedFertilizerTypes) {
                              fertilizerControllers[type] =
                                  TextEditingController();
                            }
                          });
                        },
                        hint: const Text('Select Fertilizer Types (Optional)'),
                      ),
                      const SizedBox(height: 8.0),

                      // Input fields for selected fertilizer types
                      for (String type in selectedFertilizerTypes)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextField(
                            controller: fertilizerControllers[type],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Enter $type Amount (kg)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                          ),
                        ),

                      DropDownMultiSelect(
                        options: const [
                          'CarPetrol',
                          'CarDiesel',
                          'Motorcycle',
                          'Bicycle',
                          'OnFoot',
                        ],
                        selectedValues: selectedTransportationModes,
                        onChanged: (List<String> selectedItems) {
                          setState(() {
                            selectedTransportationModes = selectedItems;
                            transportationControllers.clear();
                            for (String mode in selectedTransportationModes) {
                              transportationControllers[mode] =
                                  TextEditingController();
                            }
                          });
                        },
                        hint: const Text(
                            'Select Transportation (Optional)'),
                      ),
                      const SizedBox(height: 8.0),

                      // Input fields for selected transportation modes
                      for (String mode in selectedTransportationModes)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: TextField(
                            controller: transportationControllers[mode],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Enter $mode Distance (km)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                          ),
                        ),

                      // ElevatedButton
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            calculateCarbonEmissions();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 114, 165, 1),
                        ),
                        child: const Text(
                          'Calculate Carbon Emissions',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),

                      // Display total carbon emissions
                      const SizedBox(height: 16.0),
                      Text(
                        'Total Carbon Emissions: ${totalCarbonEmissions.toStringAsFixed(2)} CO2',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50.0),

              //bar chart section
              const Text(
                'Carbon Emissions Analysis (%)',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Visibility(
                visible: showGraph,
                child: Container(
                  height: 320,
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 216, 237, 170),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 0.2),
                      ),
                    ],
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 300,
                      width: 350,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 100,
                          barGroups: [
                            BarChartGroupData(
                              x: 0,
                              barRods: [
                                BarChartRodData(
                                  y: totalCarbonEmissions > 0
                                      ? (waterEmissions /
                                              totalCarbonEmissions) *
                                          100
                                      : 0,
                                  colors: [Colors.amber],
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(
                                  y: totalCarbonEmissions > 0
                                      ? (fertilizerEmissions /
                                              totalCarbonEmissions) *
                                          100
                                      : 0,
                                  colors: [Colors.blueGrey],
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 2,
                              barRods: [
                                BarChartRodData(
                                  y: totalCarbonEmissions > 0
                                      ? (transportationEmissions /
                                              totalCarbonEmissions) *
                                          100
                                      : 0,
                                  colors: [Colors.purpleAccent],
                                ),
                              ],
                            ),
                          ],
                          titlesData: FlTitlesData(
                            leftTitles:
                                SideTitles(showTitles: true, reservedSize: 50),
                            rightTitles: SideTitles(showTitles: false),
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTitles: (double value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return 'Water';
                                  case 1:
                                    return 'Fertilizer';
                                  case 2:
                                    return 'Transportation';
                                  default:
                                    return '';
                                }
                              },
                            ),
                            topTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: !showGraph,
                child: Container(
                  height: 320,
                  width: 370,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 216, 237, 170),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 0.2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bar_chart,
                          size: 50.0,
                          color: Color.fromARGB(255, 61, 88, 2),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Graph Preview',
                          style: TextStyle(
                            color: Color.fromARGB(255, 61, 88, 2),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Press "Calculate Carbon Emissions" to view the actual graph',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Color.fromARGB(255, 61, 88, 2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void calculateCarbonEmissions() {
    waterUsage = double.tryParse(waterUsageController.text) ?? 0.0;

    // Check if the date  is empty
    if (pickedDate == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid Date Input'),
            content: const Text('Please select a date to proceed.'),
            backgroundColor: const Color.fromARGB(255, 216, 237, 170),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  waterUsageController.clear();
                  for (String type in selectedFertilizerTypes) {
                    fertilizerControllers[type]!.clear();
                  }

                  for (String mode in selectedTransportationModes) {
                    transportationControllers[mode]!.clear();
                  }

                  setState(() {
                    showGraph = false;
                    totalCarbonEmissions = 0.0;
                  });
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    // Check if any water usage text field is empty or not a numeric value
    if (waterUsage == 0.0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid Water Usage Input'),
            content: const Text(
                'Please enter a valid non-zero numeric value for water usage .'),
            backgroundColor: const Color.fromARGB(255, 216, 237, 170),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  waterUsageController.clear();
                  for (String type in selectedFertilizerTypes) {
                    fertilizerControllers[type]!.clear();
                  }

                  for (String mode in selectedTransportationModes) {
                    transportationControllers[mode]!.clear();
                  }

                  setState(() {
                    showGraph = false;
                    totalCarbonEmissions = 0.0;
                  });
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Check if any fertilizer text field is empty or not a numeric value
    for (String type in selectedFertilizerTypes) {
      String fertilizerAmount = fertilizerControllers[type]!.text.trim();
      if (fertilizerAmount.isEmpty ||
          double.tryParse(fertilizerAmount) == null ||
          double.parse(fertilizerAmount) == 0.0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Fertilizer Type Input'),
              content: Text(
                  'Please enter a valid non-zero numeric value for $type .'),
              backgroundColor: const Color.fromARGB(255, 216, 237, 170),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    waterUsageController.clear();
                    for (String type in selectedFertilizerTypes) {
                      fertilizerControllers[type]!.clear();
                    }

                    for (String mode in selectedTransportationModes) {
                      transportationControllers[mode]!.clear();
                    }
                    setState(() {
                      showGraph = false;
                      totalCarbonEmissions = 0.0;
                    });
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }
    }

    // Check if any transportation text field is empty or not a numeric value
    for (String mode in selectedTransportationModes) {
      String transportationDistance =
          transportationControllers[mode]!.text.trim();
      if (transportationDistance.isEmpty ||
          double.tryParse(transportationDistance) == null ||
          double.parse(transportationDistance) == 0.0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Transportation Type Input'),
              content: Text(
                  'Please enter a valid non-zero numeric value for $mode .'),
              backgroundColor: const Color.fromARGB(255, 216, 237, 170),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    waterUsageController.clear();
                    for (String type in selectedFertilizerTypes) {
                      fertilizerControllers[type]!.clear();
                    }

                    for (String mode in selectedTransportationModes) {
                      transportationControllers[mode]!.clear();
                    }
                    setState(() {
                      showGraph = false;
                      totalCarbonEmissions = 0.0;
                    });
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }
    }

    fertilizerEmissions = 0.0;
    for (String type in selectedFertilizerTypes) {
      double amount = double.tryParse(fertilizerControllers[type]!.text) ?? 0.0;
      fertilizerEmissions += calculateFertilizerEmissions(amount, type);
    }

    transportationEmissions = 0.0;
    for (String mode in selectedTransportationModes) {
      double distance =
          double.tryParse(transportationControllers[mode]!.text) ?? 0.0;
      transportationEmissions +=
          calculateTransportationEmissions(distance, mode);
    }

    waterEmissions = 0.0;
    waterEmissions = calculateWaterEmissions(waterUsage);
    totalCarbonEmissions =
        waterEmissions + fertilizerEmissions + transportationEmissions;

    calculateCarbonReductionTips();
    storeEmissionsInFirebase(totalCarbonEmissions, pickedDate!);
    showResultToUser();

    setState(() {
      showGraph = true;
    });
  }

  @override
  void showResultToUser() {
    if (carbonReductionTips.isNotEmpty) {
      showCarbonReductionTips(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Carbon emissions calculated successfully.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void storeEmissionsInFirebase(double emissions, DateTime selectedDate) async {
    final DateTime now = DateTime.now();
    FirebaseService.instance.createData(emissions, now, selectedDate);
  }

  @override
  void calculateCarbonReductionTips() {
    carbonReductionTips.clear();
    // Water-related tips
    if (waterEmissions > 100) {
      carbonReductionTips.add(
          'Implement advanced water harvesting techniques and invest in water recycling systems for sustainable water management.');
    } else if (waterEmissions > 80) {
      carbonReductionTips.add(
          'Explore smart irrigation technologies to optimize water usage in your fields.');
    } else if (waterEmissions > 60) {
      carbonReductionTips.add(
          'Consider planting cover crops to improve soil water retention.');
    } else if (waterEmissions > 40) {
      carbonReductionTips.add(
          'Collect rainwater for irrigation to reduce dependency on external water sources.');
    } else if (waterEmissions > 20) {
      carbonReductionTips.add(
          'Upgrade to water-efficient irrigation methods, such as drip or sprinkler systems.');
    }

    // Fertilizer-related tips
    if (fertilizerEmissions > 100) {
      carbonReductionTips.add(
          'Implement precision agriculture techniques to optimize fertilizer application and reduce excess usage.');
    } else if (fertilizerEmissions > 80) {
      carbonReductionTips.add(
          'Explore nutrient management plans to enhance fertilizer efficiency and minimize environmental impact.');
    } else if (fertilizerEmissions > 60) {
      carbonReductionTips.add(
          'Consider using organic fertilizers and compost to promote soil health and reduce synthetic fertilizer usage.');
    } else if (fertilizerEmissions > 40) {
      carbonReductionTips.add(
          'Implement cover cropping and crop rotation practices to naturally enrich soil fertility.');
    } else if (fertilizerEmissions > 20) {
      carbonReductionTips.add(
          'Opt for slow-release fertilizers to provide nutrients to crops over an extended period.');
    }

    // Transportation-related tips
    if (transportationEmissions > 100) {
      carbonReductionTips.add(
          'Explore alternative transportation methods, such as electric vehicles or sustainable biofuels for farm-related activities.');
    } else if (transportationEmissions > 80) {
      carbonReductionTips.add(
          'Consolidate trips and optimize transportation routes to reduce fuel consumption and emissions.');
    } else if (transportationEmissions > 60) {
      carbonReductionTips.add(
          'Consider investing in energy-efficient vehicles or upgrading existing ones for reduced environmental impact.');
    } else if (transportationEmissions > 40) {
      carbonReductionTips.add(
          'Promote the use of shared transportation within the farming community to minimize individual vehicle emissions.');
    } else if (transportationEmissions > 20) {
      carbonReductionTips.add(
          'Implement routine maintenance and tune-ups for farm vehicles to ensure optimal fuel efficiency.');
    }
  }

  @override
  void showCarbonReductionTips(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 216, 237, 170),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  height: 2.5,
                  width: 70,
                  color: const Color.fromARGB(255, 50, 70, 9),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Carbon Reduction Tips',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.tips_and_updates_outlined,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 205, 214, 153),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      for (int i = 0; i < carbonReductionTips.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '${String.fromCharCode(65 + i)}. ${carbonReductionTips[i]}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  double calculateTransportationEmissions(double distance, String mode) {
    double emissionFactor;
    if (mode == 'CarPetrol') {
      emissionFactor = 0.29549;
    } else if (mode == 'CarDiesel') {
      emissionFactor = 0.25580;
    } else if (mode == 'Motorcycle') {
      emissionFactor = 0.10316;
    } else if (mode == 'Bicycle') {
      emissionFactor = 0.0;
    } else if (mode == 'OnFoot') {
      emissionFactor = 0.0;
    } else {
      emissionFactor = 0.0;
    }

    return distance * emissionFactor;
  }

  @override
  double calculateWaterEmissions(double waterUsage) {
    double waterEmissionFactor = 0.376;
    return waterUsage * waterEmissionFactor;
  }

  @override
  double calculateFertilizerEmissions(double amount, String type) {
    double fertilizerEmissionFactor;
    if (type == 'N fertilizer') {
      fertilizerEmissionFactor = 4.96;
    } else if (type == 'P fertilizer') {
      fertilizerEmissionFactor = 1.35;
    } else if (type == 'K fertilizer') {
      fertilizerEmissionFactor = 0.58;
    } else if (type == 'Pesticides') {
      fertilizerEmissionFactor = 5.10;
    } else if (type == 'Herbicide') {
      fertilizerEmissionFactor = 6.30;
    } else {
      fertilizerEmissionFactor = 0.0;
    }

    return amount * fertilizerEmissionFactor;
  }
}
