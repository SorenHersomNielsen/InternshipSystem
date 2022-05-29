class GroupOfPeople {
  final int id;
  final int groupId;
  final int personId;

  const GroupOfPeople({
    required this.id,
    required this.groupId,
    required this.personId,
  });

  factory GroupOfPeople.fromJson(Map<String, dynamic> json) {
    return GroupOfPeople(
      id: json['id'],
      groupId: json['groupId'],
      personId: json['personId'],
    );
  }
}
