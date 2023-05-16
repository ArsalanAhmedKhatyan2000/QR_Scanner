import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/survey_information_model.dart';

class TraineeCard extends StatelessWidget {
  final Trainees? _traineeInfo;
  const TraineeCard({Key? key, required Trainees? traineeInfo})
      : _traineeInfo = traineeInfo,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildLabelWithValueVertically(
                label: "Trainee Name", value: _traineeInfo?.name.toString()),
            SizedBox(height: 10.h),
            BuildLabelWithValueVertically(
                label: "Email", value: _traineeInfo?.email.toString()),
            SizedBox(height: 10.h),
            BuildLabelWithValueVertically(
                label: "Designation",
                value: _traineeInfo?.designations.toString()),
            SizedBox(height: 10.h),
            BuildLabelWithValueVertically(
                label: "Area Of Expertise",
                value: _traineeInfo?.areaOfExpertise.toString()),
            SizedBox(height: 10.h),
            BuildLabelWithValueVertically(
                label: "CNIC", value: _traineeInfo?.nic.toString()),
            SizedBox(height: 10.h),
            BuildLabelWithValueVertically(
                label: "Date of Birth", value: _traineeInfo?.dob.toString()),
          ],
        ),
      ),
    );
  }
}

class BuildLabelWithValueVertically extends StatelessWidget {
  final String? _label;
  final String? _value;

  const BuildLabelWithValueVertically({
    Key? key,
    required String? label,
    required String? value,
  })  : _label = label,
        _value = value,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _label.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.h),
        Text(_value.toString()),
      ],
    );
  }
}
