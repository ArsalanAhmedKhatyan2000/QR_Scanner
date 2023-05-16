class SurveyInformationModel {
  bool? verified;
  Data? data;

  SurveyInformationModel({this.verified, this.data});

  SurveyInformationModel.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = verified;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? organizationName;
  String? aboutOrganization;
  String? organizationResponsibility;
  bool? organizationSuccess;
  String? organizationPurpse;
  List<Trainees>? trainees;

  Data(
      {this.sId,
      this.organizationName,
      this.aboutOrganization,
      this.organizationResponsibility,
      this.organizationSuccess,
      this.organizationPurpse,
      this.trainees});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    organizationName = json['organizationName'];
    aboutOrganization = json['aboutOrganization'];
    organizationResponsibility = json['organizationResponsibility'];
    organizationSuccess = json['organizationSuccess'];
    organizationPurpse = json['organizationPurpse'];
    if (json['trainees'] != null) {
      trainees = <Trainees>[];
      json['trainees'].forEach((v) {
        trainees!.add(Trainees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['organizationName'] = organizationName;
    data['aboutOrganization'] = aboutOrganization;
    data['organizationResponsibility'] = organizationResponsibility;
    data['organizationSuccess'] = organizationSuccess;
    data['organizationPurpse'] = organizationPurpse;
    if (trainees != null) {
      data['trainees'] = trainees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Trainees {
  String? name;
  String? email;
  String? nic;
  String? areaOfExpertise;
  String? designations;
  String? dob;
  String? sId;

  Trainees(
      {this.name,
      this.email,
      this.nic,
      this.areaOfExpertise,
      this.designations,
      this.dob,
      this.sId});

  Trainees.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    nic = json['nic'];
    areaOfExpertise = json['areaOfExpertise'];
    designations = json['designations'];
    dob = json['Dob'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['nic'] = nic;
    data['areaOfExpertise'] = areaOfExpertise;
    data['designations'] = designations;
    data['Dob'] = dob;
    data['_id'] = sId;
    return data;
  }
}
