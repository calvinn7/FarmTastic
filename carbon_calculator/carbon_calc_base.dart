// ignore: file_names
import 'package:flutter/material.dart';

abstract class CarbonCalculatorBase extends StatefulWidget {
  const CarbonCalculatorBase({Key? key}) : super(key: key);
}

abstract class CarbonCalculatorBaseState<T extends CarbonCalculatorBase> extends State<T> {
  TextEditingController waterUsageController = TextEditingController();
  List<String> selectedFertilizerTypes = [];
  List<String> selectedTransportationModes = [];
  Map<String, TextEditingController> fertilizerControllers = {};
  Map<String, TextEditingController> transportationControllers = {};
  double totalCarbonEmissions = 0.0;
  double waterUsage = 0.0;
  double fertilizerEmissions = 0.0;
  double waterEmissions = 0.0;
  double transportationEmissions = 0.0;
  List<String> carbonReductionTips = [];
  bool showGraph = false;
  String buttonText = 'Choose Date';
  DateTime? pickedDate;
  late DateTime currentDate;
  

  void calculateCarbonEmissions();

  void showResultToUser();

  void calculateCarbonReductionTips();

  void showCarbonReductionTips(BuildContext context);

  double calculateTransportationEmissions(double distance, String mode);

  double calculateWaterEmissions(double waterUsage);

  double calculateFertilizerEmissions(double amount, String type);
}
