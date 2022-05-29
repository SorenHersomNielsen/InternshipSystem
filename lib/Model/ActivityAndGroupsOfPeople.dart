class ActivityAndGroupsOfPeople {
  final int id;
  final int activityId;
  final int groupsOfPeopleId;

  const ActivityAndGroupsOfPeople({
    required this.id,
    required this.activityId,
    required this.groupsOfPeopleId,
  });

  factory ActivityAndGroupsOfPeople.fromJson(Map<String, dynamic> json) {
    return ActivityAndGroupsOfPeople(
      id: json['id'],
      activityId: json['activityId'],
      groupsOfPeopleId: json['groupsOfPeopleId'],
    );
  }
}
