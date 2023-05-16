import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../controller.dart/information_controller.dart';
import '../../widgets/code_field.dart';
import '../../widgets/custom_button.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({super.key});

  @override
  State<QRCodeScannerScreen> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  Barcode? _result;

  //CODE
  TextEditingController? controller1 = TextEditingController();
  TextEditingController? controller2 = TextEditingController();
  TextEditingController? controller3 = TextEditingController();
  TextEditingController? controller4 = TextEditingController();
  //qr
  void qr(QRViewController? controller) {
    _controller = controller;
    _controller?.scannedDataStream.listen((event) {
      // _result != null ? _controller?.stopCamera() : _controller?.resumeCamera();
      setState(() {
        _result = event;
      });
    });
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller!.resumeCamera();
    } else if (Platform.isIOS) {
      _controller!.resumeCamera();
    }
  }

  void readQr() async {
    if (_result != null) {
      _controller!.pauseCamera();
      print(_result!.code);
      _controller!.dispose();
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // for auto hot reload
    if (_controller != null && mounted) {
      setState(() {
        _controller!.resumeCamera();
      });
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 1.sh * 0.6,
                  width: 1.sw,
                  child: QRView(
                    key: _qrKey,
                    onQRViewCreated: qr,
                    overlay: QrScannerOverlayShape(
                      borderColor: const Color(0xff009688),
                      borderRadius: 35,
                      borderLength: 70,
                      borderWidth: 5,
                      cutOutSize: 300,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                _result != null
                    ? CustomButton(
                        label: "Verify QR Code",
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          final id = jsonDecode(_result!.code.toString())['id'];
                          setState(() {
                            _result = null;
                          });
                          final informationController =
                              Provider.of<InformationController>(context,
                                  listen: false);
                          await informationController.fetchInformation(
                              context: context, id: id.toString());
                          setState(() {
                            isLoading = false;
                          });
                        },
                      )
                    : Text(
                        "Scan Qr Code\nOR\nEnter the secret code",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CodeField(
                        first: true, last: false, controller: controller1),
                    CodeField(
                        first: false, last: false, controller: controller2),
                    CodeField(
                        first: false, last: false, controller: controller3),
                    CodeField(
                        first: false, last: true, controller: controller4),
                  ],
                ),
                CustomButton(
                  label: "Verify code",
                  onPressed: () async {
                    // "6848"
                    setState(() {
                      isLoading = true;
                    });
                    final code =
                        "${controller1?.text.trim()}${controller2?.text.trim()}${controller3?.text.trim()}${controller4?.text.trim()}";
                    final informationController =
                        Provider.of<InformationController>(context,
                            listen: false);
                    await informationController.postCodeAndFetchInformation(
                        context: context, code: code.trim().toString());
                    setState(() {
                      isLoading = false;
                    });
                  },
                )
              ],
            ),
            isLoading == true
                ? Container(
                    height: 1.sh,
                    width: 1.sw,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(
                          color: Color(0xff009688),
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
