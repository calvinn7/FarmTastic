class Event {
  String title;
  bool checked;

  Event({required this.title, required this.checked});

  // Convert Event to a map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'checked': checked,
    };
  }

  // Create an Event from a map
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      checked: json['checked'],
    );
  }
}