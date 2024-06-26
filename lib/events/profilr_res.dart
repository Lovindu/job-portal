import 'dart:convert';

ProfileRes profileResFromJson(String str) =>
    ProfileRes.fromJson(json.decode(str));

String profileResToJson(ProfileRes data) => json.encode(data.toJson());

class ProfileRes {
  ProfileRes({
    required this.id,
    required this.username,
    required this.email,
    required this.isAdmin,
    required this.isAgent,
    required this.skills,
    required this.location,
    required this.phone,
    required this.profile,
  });

  factory ProfileRes.fromJson(Map<String, dynamic> json) => ProfileRes(
        id: json['_id'],
        username: json['username'],
        email: json['email'],
        isAdmin: json['isAdmin'],
        isAgent: json['isAgent'],
        skills: List<String>.from(json['skills'].map((x) => x)),
        location: json['location'],
        phone: json['phone'],
        profile: json['profile'],
      );

  final String id;
  final String username;
  final String email;
  final bool isAdmin;
  final bool isAgent;
  final List<String> skills;
  final String location;
  final String phone;
  final String profile;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'username': username,
        'email': email,
        'isAdmin': isAdmin,
        'isAgent': isAgent,
        'skills': List<dynamic>.from(skills.map((x) => x)),
        'location': location,
        'phone': phone,
        'profile': profile,
      };
}