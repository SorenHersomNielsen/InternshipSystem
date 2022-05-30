class Status {
  final int id;
  final int personId;
  final String myStatus;

  const Status(
      {required this.id,
        required this.personId,
        required this.myStatus,
    });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
        id: json['id'],
        personId: json['personId'],
        myStatus: json['myStatus'],
   );
  }
}