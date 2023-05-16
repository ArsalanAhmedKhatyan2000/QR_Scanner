import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../core/constant.dart';

class QrVerifyRepoditory {
  static Future<http.Response> getVerifyQRData(
      {required BuildContext context, required String? id}) async {
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}/organization/$id");
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      switch (response.statusCode) {
        case 200:
          return response;
        default:
          return response;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  //verify code
  static Future<http.Response> verifyCode(
      {required BuildContext context, required String? code}) async {
    try {
      var url = Uri.parse(
          "http://ec2-35-74-182-67.ap-northeast-1.compute.amazonaws.com:4000/organization/verify");
      var response = await http.post(
        url,
        body: jsonEncode({"qrCode": code}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      switch (response.statusCode) {
        case 200:
          return response;
        default:
          return response;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
