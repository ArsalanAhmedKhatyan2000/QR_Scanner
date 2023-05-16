import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../controller.dart/information_controller.dart';
import '../../widgets/survey_information_header.dart';
import '../../widgets/trainee_card.dart';
import '../survey/qrcode_scanner.dart';

class SurveyInformation extends StatelessWidget {
  const SurveyInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final informationController = Provider.of<InformationController>(context);
    final information = informationController.getInformationModel();
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const QRCodeScannerScreen(),
            ));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff009688),
          centerTitle: true,
          title: const Text("Information"),
          leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const QRCodeScannerScreen(),
                )),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Organization",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700)),
              SurveyInformationHeader(data: information?.data),
              SizedBox(height: 10.h),
              Text("List Of Trainees",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 10.h),
              information!.data!.trainees!.isNotEmpty
                  ? Expanded(
                      flex: 1,
                      child: ListView.separated(
                        itemCount: information.data!.trainees!.length,
                        // physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 5.h),
                        itemBuilder: (context, index) => TraineeCard(
                            traineeInfo: information.data!.trainees![index]),
                      ))
                  : Text("No Data Found"),
            ],
          ),
        ),
      ),
    );
  }
}
