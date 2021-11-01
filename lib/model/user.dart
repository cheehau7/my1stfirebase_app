class User {
  final String? name;
  final int? age;
  final String? email;
  final String? uuid;
  final String? image;

  User({this.name, this.age, this.email, this.uuid, this.image});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = int.tryParse(json['age']) ?? 0,
        email = json['email'],
        uuid = json['uuid'],
        image = json['image'];
  //User.second({required this.name, required this.age});
}
