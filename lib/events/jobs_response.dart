import 'dart:convert';

List<JobsResponse> jobsResponseFromJson(String str) => List<JobsResponse>.from(
    json.decode(str).map((x) => JobsResponse.fromJson(x)));

class JobsResponse {
  final String id;
  final String title;
  final String location;
  final String company;
  final String description;
  final String contract;
  final String agentName;
  final String salary;
  final String period;
  final bool hiring;
  final List<String> requirements;
  final String imageUrl;
  final String agentId;

  JobsResponse({
    required this.id,
    required this.title,
    required this.location,
    required this.company,
    required this.description,
    required this.contract,
    required this.agentName,
    required this.salary,
    required this.period,
    required this.hiring,
    required this.requirements,
    required this.imageUrl,
    required this.agentId,
  });

  factory JobsResponse.fromJson(Map<String, dynamic> json) => JobsResponse(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        company: json["company"],
        description: json["description"],
        contract: json["contract"],
        agentName: json["agentName"],
        salary: json["salary"],
        period: json["period"],
        hiring: json["hiring"],
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        imageUrl: json["imageUrl"],
        agentId: json["agentId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "company": company,
        "description": description,
        "contract":contract,
        "agentName": agentName,
        "salary": salary,
        "period": period,
        "hiring": hiring,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        "imageUrl": imageUrl,
        "agentId": agentId,
      };
}
