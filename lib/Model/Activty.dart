class Activity {
  final int Id;
  final String Headline;
  final String Date;

  const Activity({
    required this.Id,
    required this.Headline,
    required this.Date,
  });

  factory Activity.fromJson(Map<String,dynamic> json) {
    return Activity(
        Id: json['id'],
        Headline: json['headline'],
        Date: json['date'],
    );
  }
}