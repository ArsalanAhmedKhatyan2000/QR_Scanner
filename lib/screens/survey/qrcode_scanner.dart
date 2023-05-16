import 'dart:convert';
import 'dart:io';
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
    setState(() {
      _controller = controller;
    });
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
  void reassemble() async {
    super.reassemble();
    if (_controller != null) {
      debugPrint('reassemble : $_controller');
      if (Platform.isAndroid) {
        await _controller!.pauseCamera();
      } else if (Platform.isIOS) {
        await _controller!.resumeCamera();
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void readQr() async {
    if (_result != null) {
      _controller!.pauseCamera();
      _controller!.dispose();
    }
  }

  bool isLoading = false;
  reloadCamera() async {
    // for auto hot reload
    // _controller != null && mounted
    if (_controller != null && mounted) {
      await _controller!.resumeCamera();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    reloadCamera();
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
                          final code =
                              jsonDecode(_result!.code.toString())['qrCode'];
                          setState(() {
                            _result = null;
                          });
                          final informationController =
                              Provider.of<InformationController>(context,
                                  listen: false);
                          await informationController
                              .postCodeAndFetchInformation(
                                  context: context,
                                  code: code.trim().toString());
                          // await informationController.fetchInformation(
                          //     context: context, id: id.toString());
                          setState(() {
                            isLoading = false;
                          });
                        },
                      )
                    : Text(
                        "Scan Qr Code",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.sp),
                      ),
                Text(
                  "OR\nEnter the secret code",
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
                ? SizedBox(
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
}
