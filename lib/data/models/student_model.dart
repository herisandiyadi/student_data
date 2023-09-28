class StudentModel {
  final int? id;
  final String name;
  final String birtDate;
  final int age;
  final int gender;
  final String address;

  const StudentModel({
    this.id,
    required this.address,
    required this.age,
    required this.birtDate,
    required this.gender,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'birthDate': birtDate,
        'age': age,
        'gender': gender,
        'address': address,
      };
}
