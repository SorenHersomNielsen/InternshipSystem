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
    print(datetimejson);
    final dateTime = DateTime.parse(datetimejson);
    print(dateTime);
    final format = DateFormat('kk:mm dd.MM.yyyy');
    final finaltime = format.format(dateTime);
    print(finaltime);
    return Activity(
      Id: json['id'],
      Headline: json['headline'],
      Date: finaltime,
    );
  }
}
