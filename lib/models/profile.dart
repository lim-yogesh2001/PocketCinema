class Profile {
  Profile({
    required this.username,
    required this.email,
    required this.phone,
    required this.fullName,
    required this.dateJoined,
  });
  final String? username;
  final String? email;
  final String? phone;
  final String? fullName;
  final DateTime? dateJoined;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        fullName: json['full_name'],
        dateJoined: DateTime.parse(json['date_joined']),
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['username'] = username;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['full_name'] = fullName;
    _data['date_joined'] = dateJoined?.toIso8601String();
    return _data;
  }
}
