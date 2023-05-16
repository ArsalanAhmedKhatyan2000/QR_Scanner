import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matz/widgets/trainee_card.dart';

import '../models/survey_information_model.dart';

class SurveyInformationHeader extends StatelessWidget {
  final Data? _data;
  const SurveyInformationHeader({super.key, required Data? data})
      : _data = data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 1.sw,
        height: 1.sh * 0.4,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildLabelWithValueVertically(
                    label: "Organization Name : ",
                    value: _data!.organizationName.toString()),
                SizedBox(height: 10.h),
                BuildLabelWithValueVertically(
                    label: "About Organization : ",
                    value: _data!.aboutOrganization.toString()),
                SizedBox(height: 10.h),
                BuildLabelWithValueVertically(
                    label: "Organization Responsibility : ",
                    value: _data!.organizationResponsibility.toString()),
                SizedBox(height: 10.h),
                BuildLabelWithValueVertically(
                    label: "Organization Purpse : ",
                    value: _data!.organizationPurpse.toString()),
                // Text(information!.data!.organizationName.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
