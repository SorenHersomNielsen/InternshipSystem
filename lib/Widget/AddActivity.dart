import 'package:flutter/material.dart';
import 'package:internship/Viewmodel.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({Key? key, required this.restorationId}) : super(key: key);

  final String? restorationId;

  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> with RestorationMixin {
  final _formKey = GlobalKey<FormState>();
  late String _Headline;
  late int _Hour;
  late int _min;
  late int day;
  late int month;
  late int year;
  String activityDay = 'Vælg dag';

  final viewmodel = Viewmodel();

  String? _selectedTime = 'Vælg tide';

  Future<void> _show() async {
    final TimeOfDay? result =
     await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                // Using 24-Hour format
                  alwaysUse24HourFormat: true),

              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: childWidget!);
        });
    setState(() {
      if(result != null){
        final String hour = result.hour.toString();
        final String min = result.minute.toString();

        _selectedTime = '$hour:$min';
        _Hour = result.hour;
        _min = result.minute;
      }
    });
  }


  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2022),
          lastDate: DateTime(2050),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        day = _selectedDate.value.day;
        month = _selectedDate.value.month;
        year = _selectedDate.value.year;

        activityDay = '$day:$month:$year';
      });
    }
  }

  final snackbarFail = const SnackBar(
    content: Text('noget gik galt, prøve igen :('),
    backgroundColor: Colors.red,
  );

  final snackbarGood = const SnackBar(
    content: Text('Aktiviteten er oprettet'),
    backgroundColor: Colors.green,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Overskrift'),
                    onChanged: (value) {
                      _Headline = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'være venlig at skrive overskrift';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      _restorableDatePickerRouteFuture.present();
                    },
                    child: Text(activityDay),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _show,
                    child: Text('$_selectedTime'),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text(
                      'Oprettet Aktivitet',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {

                        final DateTime todatetime = DateTime(year,month,day, _Hour, _min );

                        viewmodel.createActivity(_Headline, todatetime)
                            .then((value) => {

                          if (value != null)
                            {
                             ScaffoldMessenger.of(context).showSnackBar(snackbarGood)
                            }
                          else
                            {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbarFail)
                            }
                        });
                      };
                    },
                  ),
                ]))));
  }
}
