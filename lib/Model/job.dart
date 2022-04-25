// ignore_for_file: constant_identifier_names

class Job {
  final int id;
  final Company company;
  final String title;
  final String description;
  final String requirements;
  final String location;
  final int salary;
  final DateTime postedDate;
  final DateTime endDate;
  final Sector sector;

  Job(
      {required this.id,
      required this.company,
      required this.title,
      required this.description,
      required this.requirements,
      required this.location,
      required this.salary,
      required this.postedDate,
      required this.endDate,
      required this.sector});
  factory Job.fromJson(Map<String,dynamic> json) {
    return Job(
      id: json['id'] as int,
      company: Company.fromJson(json['company'] as Map<String,dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      requirements: json['requirements'] as String,
      location: json['location'] as String,
      salary: json['salary'] as int,
      postedDate: DateTime.parse(json['posted_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      sector: sectorFromString(json['sector'] as String),
    );
  }
}

class Company {
  final int id;
  final String name;
  final String description;
  final String website;
  final String email;
  final String phone;
  final String city;

  Company(
      {required this.id,
      required this.name,
      required this.description,
      required this.website,
      required this.email,
      required this.phone,
      required this.city});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      website: json['website'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
    );
  }
}

enum Sector {
  HEALTH_CARE,
  LEISURE,
  RETAIL,
  EDUCATION,
  FINANCE,
  BUSINESS,
  IT,
  OTHER
}

Sector sectorFromString(String name) {
  switch (name) {
    case 'HEALTH_CARE':
      return Sector.HEALTH_CARE;
    case 'LEISURE':
      return Sector.LEISURE;
    case 'RETAIL':
      return Sector.RETAIL;
    case 'EDUCATION':
      return Sector.EDUCATION;
    case 'FINANCE':
      return Sector.FINANCE;
    case 'BUSINESS':
      return Sector.BUSINESS;
    case 'IT':
      return Sector.IT;
    case 'OTHER':
      return Sector.OTHER;
    default:
      return Sector.OTHER;
  }
}