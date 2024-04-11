import 'dart:convert';

GetJobRes getJobResFromJson(String str) {
  final jsonData = json.decode(str);
  return GetJobRes.fromJson(jsonData);
}

String getJobResToJson(GetJobRes data) => json.encode(data.toJson());

class GetJobRes {
  final String id;
  final String title;
  final String location;
  final String company;
  final String contract;
  final String description;
  final String agentName;
  final String salary;
  final String period;
  final bool hiring;
  final List<String> requirements;
  final String imageUrl;
  final String agentId;

  GetJobRes({
    required this.id,
    required this.title,
    required this.location,
    required this.company,
    required this.contract,
    required this.description,
    required this.agentName,
    required this.salary,
    required this.period,
    required this.hiring,
    required this.requirements,
    required this.imageUrl,
    required this.agentId,
  });

  factory GetJobRes.fromJson(Map<String, dynamic> json) => GetJobRes(
        id: json["_id"],
        title: json["title"],
        location: json["location"],
        company: json["company"],
        contract: json["contract"],
        description: json["description"],
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
        "contract":contract,
        "description": description,
        "agentName": agentName,
        "salary": salary,
        "period": period,
        "hiring": hiring,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        "imageUrl": imageUrl,
        "agentId": agentId,
      };
}
