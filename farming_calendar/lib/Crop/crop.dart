class Crop {
  int? id;
  String? title;
  int? duration;
  String? startDate;
  String? endDate;
  int? remind;

  Crop({
    this.id,
    this.title,
    this.duration,
    this.startDate,
    this.endDate,
    this.remind,
  });

  Crop.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'].toString();
    duration = json['duration'];
    startDate = json['startTime'];
    endDate = json['endTime'];
    remind = json['remind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.duration;
    data['startTime'] = this.startDate;
    data['endTime'] = this.endDate;
    data['remind'] = this.remind;

    return data;
  }
}
