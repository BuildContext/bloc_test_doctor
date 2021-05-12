class Doctor {
  int id;
  String firstName;
  String lastName;
  String description =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
  String workingHours = '10:00 - 18:00';
  String speciality;
  String? avatarLink;
  String detailsLink;

  Doctor(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.avatarLink,
      required this.speciality,
      required this.detailsLink});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: int.parse(json['id']),
      firstName: json['firstName'],
      lastName: json['lastName'],
      avatarLink: json['avatar'] != '' ? json['avatar'] : null,
      speciality: json['speciality'] is List<dynamic>
          ? json['speciality'].join(', ')
          : json['speciality'],
      detailsLink: json['link'],
    );
  }
}
