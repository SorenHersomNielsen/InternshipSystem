class Person {
  final int Id;
  final String Name;
  final String Mail;
  final String Password;
  final String TelephoneNumber;
  final String Internship;
  final String School;
  final String Role;


  const Person({
    required this.Id,
    required this.Name,
    required this.Mail,
    required this.Password,
    required this.TelephoneNumber,
    required this.Internship,
    required this.School,
    required this.Role
  });

  factory Person.fromJson(Map<String,dynamic> json) {
    return Person(
      Id: json['id'],
      Name: json['name'],
      Mail: json['mail'],
      Password: json['password'],
      TelephoneNumber: json['telephoneNumber'],
      Internship: json['internship'],
      School: json['school'],
      Role: json['role']
    );
  }
}