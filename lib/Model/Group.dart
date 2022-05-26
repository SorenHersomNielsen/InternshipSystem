class Group {
  final int Id;
  final String Name;


  const Group(
      {required this.Id,
        required this.Name});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
        Id: json['id'],
        Name: json['name']);
  }
}
