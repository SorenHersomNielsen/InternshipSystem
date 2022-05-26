class ActivityStatus {
  final int Id;
  final int activityId;
  final int statusId;

  const ActivityStatus({
    required this.Id,
    required this.activityId,
    required this.statusId,
  });

  factory ActivityStatus.fromJson(Map<String, dynamic> json) {
    return ActivityStatus(
      Id: json['id'],
      activityId: json['activityId'],
      statusId: json['statusId'],
    );
  }
}
