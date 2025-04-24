class Person{
  final String name;
  final int age;
  final String email;

  Person({required this.name, required this.age, required this.email});

  factory Person.fromJson(Map<String, dynamic> json){
    return Person(
      age : json['age'],
      email : json['email'],
      name : json['name'],
    );
  }
}