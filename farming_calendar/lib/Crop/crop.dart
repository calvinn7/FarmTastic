class Crop {
  int? id;
  String? plant;
  int? duration;
  int? color;
  String? startDate;
  String? endDate;
  int? remind;

  Crop({
    this.id,
    this.plant,
    this.duration,
    this.color,
    this.startDate,
    this.endDate,
  });

  Crop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plant = json['plant'].toString();
    duration = json['duration'];
    color = json['color'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plant'] = this.plant;
    data['duration'] = this.duration;
    data['color'] = this.color;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;

    return data;
  }
}
