import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/survey_information_model.dart';
import '../repositories/qr_verify_repository.dart';
import '../screens/details/information.dart';
import '../widgets/unverified_diaglog.dart';

class InformationController with ChangeNotifier {
  SurveyInformationModel? information;

  SurveyInformationModel? getInformationModel() {
    return information;
  }

  Future<void> fetchInformation(
      {required BuildContext context, required String id}) async {
    final response =
        await QrVerifyRepoditory.getVerifyQRData(context: context, id: id);
    if (response.statusCode == 200) {
      information = SurveyInformationModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      if (information?.verified == true) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SurveyInformation()));
      } else {
        showDialog(
          context: context,
          builder: (context) => const UnVerifyStatusDialog(),
        );
      }
    }
  }

  Future<void> postCodeAndFetchInformation(
      {required BuildContext context, required String code}) async {
    final response =
        await QrVerifyRepoditory.verifyCode(context: context, code: code);
    if (response.statusCode == 200) {
      information = SurveyInformationModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      if (information?.verified == true) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SurveyInformation()));
      } else {
        showDialog(
          context: context,
          builder: (context) => const UnVerifyStatusDialog(),
        );
      }
    }
  }
}
