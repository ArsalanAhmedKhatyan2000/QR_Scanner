import 'package:flutter/material.dart';

class UnVerifyStatusDialog extends StatelessWidget {
  const UnVerifyStatusDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [Text("Sorry, not verified.")],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(backgroundColor: Colors.red.shade400),
              child: const Text("Cancel"),
            ),
          ),
          Positioned(
            top: -50,
            right: 50,
            left: 50,
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.red.shade400,
              child: const Icon(Icons.cancel_outlined,
                  color: Colors.white, size: 50),
            ),
          ),
          // SvgPicture.asset(
          //   'assets/images/svg/verified_icon.svg',
          //   color: const Color(0xff009688),
          // ),
        ],
      ),
    );
  }
}
