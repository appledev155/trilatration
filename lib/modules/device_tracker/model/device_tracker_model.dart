class DeviceTrackerModel {
  final String? devicetrack;
  final String? duration;
  final double? xcoordinate;
  final double? ycoordinate;

  DeviceTrackerModel({
    this.devicetrack,
    this.duration,
    this.xcoordinate,
    this.ycoordinate,
  });

  factory DeviceTrackerModel.fromJson(Map<String, dynamic> json) {
    return DeviceTrackerModel(
      devicetrack: json['dt_mac'],
      duration: json['updated_at'],
      xcoordinate: json['x_coordinate'],
      ycoordinate: json['y_coordinate'],
    );
  }
}
