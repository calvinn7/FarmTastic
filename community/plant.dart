class Plant {
  final int plantId;
  final String size;
  final double rating;
  final int humidity;
  final String temperature;
  final String category;
  final String plantName;
  final String imageURL;
  bool isFavorated;
  final String decription;
  bool isSelected;

  Plant(
      {required this.plantId,
      required this.category,
      required this.plantName,
      required this.size,
      required this.rating,
      required this.humidity,
      required this.temperature,
      required this.imageURL,
      required this.isFavorated,
      required this.decription,
      required this.isSelected});

  //List of Plants data
  static List<Plant> plantList = [
    Plant(
        plantId: 0,
        category: 'Vegetable',
        plantName: 'Tomato',
        size: '3-10 feet',
        rating: 5.0,
        humidity: 60,
        temperature: '18 - 29',
        imageURL: 'assets/tomato.png',
        isFavorated: false,
        decription:
            'Grow tomatoes in fertile, well-drained soil with full sun exposure.',
        isSelected: false),
    Plant(
        plantId: 1,
        category: 'Grain',
        plantName: 'Corn',
        size: '7-10 feet',
        rating: 4.9,
        humidity: 70,
        temperature: '21 - 27',
        imageURL: 'assets/corn.png',
        isFavorated: false,
        decription:
            'Plant corn seeds in blocks to aid in pollination, in fertile, well-drained soil.',
        isSelected: false),
    Plant(
        plantId: 2,
        category: 'Vegetable',
        plantName: 'Cabbage',
        size: '1.5-2 feet',
        rating: 4.8,
        humidity: 70,
        temperature: '15 - 24',
        imageURL: 'assets/cabbage.png',
        isFavorated: false,
        decription:
            'Grow cabbage in rich, well-drained soil in cooler temperatures.',
        isSelected: false),
    Plant(
        plantId: 3,
        category: 'Vegetable',
        plantName: 'Potato',
        size: '1-3 feet',
        rating: 4.7,
        humidity: 60,
        temperature: '15 - 20',
        imageURL: 'assets/potato.png',
        isFavorated: false,
        decription:
            'Plant potatoes in loose, well-drained soil, preferably in cooler climates.',
        isSelected: false),
    Plant(
        plantId: 4,
        category: 'Vegetable',
        plantName: 'Onion',
        size: '1-3 feet',
        rating: 4.6,
        humidity: 50,
        temperature: '13 - 24',
        imageURL: 'assets/onion.png',
        isFavorated: true,
        decription:
            'Plant onion sets in loose, well-drained soil, with bulbs partially above.',
        isSelected: false),
    Plant(
        plantId: 5,
        category: 'Fruit',
        plantName: 'Apple',
        size: '10-30 feet',
        rating: 4.5,
        humidity: 60,
        temperature: '21 - 24',
        imageURL: 'assets/apple.png',
        isFavorated: false,
        decription:
            'Plant apple trees in well-drained soil, preferably on a sunny slope.',
        isSelected: false),
    Plant(
        plantId: 6,
        category: 'Fruit',
        plantName: 'Banana',
        size: '5-25 feet',
        rating: 4.4,
        humidity: 80,
        temperature: '27 - 30',
        imageURL: 'assets/banana.png',
        isFavorated: false,
        decription:
            'Plant bananas in fertile, well-drained soil with high humidity and warmth.',
        isSelected: false),
    Plant(
        plantId: 7,
        category: 'Fruit',
        plantName: 'Papaya',
        size: '15-30 feet',
        rating: 4.3,
        humidity: 70,
        temperature: '24 - 33',
        imageURL: 'assets/papaya.png',
        isFavorated: false,
        decription:
            'Plant papayas in warm, well-drained soil with consistent moisture.',
        isSelected: false),
    Plant(
        plantId: 8,
        category: 'Recommended',
        plantName: 'Wheat',
        size: '6-8 feet',
        rating: 4.2,
        humidity: 55,
        temperature: '20 - 24',
        imageURL: 'assets/wheat.png',
        isFavorated: false,
        decription:
            'Wheat planting involves sowing seeds at specific depths and spacing, considering temperature requirements, and nurturing the crop through various growth stages to yield healthy grain.',
        isSelected: false),
  ];
}
