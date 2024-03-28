
// Zone model
class Zone {
  final dynamic id;
  final String name;

  Zone({required this.id, required this.name});

  factory Zone.fromJson(Map<List, dynamic> json) {
    return Zone(
      id: json['id'],
      name: json['name'],
    );
  }
}


