// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'plant.dart';

class DetailPage extends StatefulWidget {
  final int plantId;
  const DetailPage({Key? key, required this.plantId}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Plant> _plantList = Plant.plantList;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromARGB(255, 47, 142, 101).withOpacity(.15),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Color.fromARGB(255, 47, 142, 101),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              width: size.width * .8,
              height: size.height * .8,
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 0,
                    child: SizedBox(
                      height: 200,
                      child: Image.asset(_plantList[widget.plantId].imageURL),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PlantFeature(
                            title: 'Size',
                            plantFeature: _plantList[widget.plantId].size,
                          ),
                          PlantFeature(
                            title: 'Humidity',
                            plantFeature:
                                _plantList[widget.plantId].humidity.toString(),
                          ),
                          PlantFeature(
                            title: 'Temperature',
                            plantFeature:
                                _plantList[widget.plantId].temperature,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
              height: size.height * .5,
              width: size.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 47, 142, 101).withOpacity(.4),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _plantList[widget.plantId].plantName,
                            style: TextStyle(
                              color: Color.fromARGB(255, 47, 142, 101),
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            _plantList[widget.plantId].rating.toString(),
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Color.fromARGB(255, 47, 142, 101),
                            ),
                          ),
                          Icon(
                            Icons.star,
                            size: 30.0,
                            color: Color.fromARGB(255, 47, 142, 101),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Expanded(
                    child: Text(
                      _plantList[widget.plantId].decription,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 18,
                        color: Colors.black.withOpacity(.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlantFeature extends StatelessWidget {
  final String plantFeature;
  final String title;
  const PlantFeature({
    Key? key,
    required this.plantFeature,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: Color.fromARGB(255, 47, 142, 101),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}