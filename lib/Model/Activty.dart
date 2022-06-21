import 'package:intl/intl.dart';

class Activity {
  final int Id;
  final String Headline;
  final String Date;

  const Activity({
    required this.Id,
    required this.Headline,
    required this.Date,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {

    final datetimejson = json['date'];
    final dateTime = DateTime.parse(datetimejson);
    final format = DateFormat('kk:mm dd.MM.yyyy');
    final finaltime = format.format(dateTime);
    return Activity(
      Id: json['id'],
      Headline: json['headline'],
      Date: finaltime,
    );
  }
}
