import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

class VerifyEmail extends StatefulWidget {
  final Function sendOTP;
  final Function verifyOTP;
  final TextEditingController otpController;
  int timer;
  int maxAttempts;
  bool isOTPSent;
  bool isResend;
  final Function onTimerTick;
  final Function onTimerFinish;

  VerifyEmail({
    Key? key,
    required this.sendOTP,
    required this.verifyOTP,
    required this.otpController,
    required this.timer,
    required this.maxAttempts,
    required this.isOTPSent,
    required this.isResend,
    required this.onTimerTick,
    required this.onTimerFinish,
  }) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.isOTPSent && widget.timer > 0) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.timer > 0) {
        widget.onTimerTick();
      } else {
        _timer?.cancel();
        widget.onTimerFinish();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Dimensions.screenHeight / 46.6,
        left: Dimensions.screenWidth / 21.5,
        right: Dimensions.screenWidth / 21.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: widget.otpController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]')), // only allow digits
                ],
                decoration: InputDecoration(
                  hintText: "Enter OTP",
                  suffix: widget.isOTPSent ? Text('${widget.timer} s') : null,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Dimensions.screenHeight / 62.133,
                    horizontal: Dimensions.screenWidth / 21.5,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: Dimensions.screenWidth / 430,
                      color: AppColors.mainPurple,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.screenHeight / 62.133,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: Dimensions.screenWidth / 286.667,
                      color: AppColors.mainPurple,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.screenHeight / 62.133,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: Dimensions.screenWidth / 43,
                child: !widget.isOTPSent && widget.maxAttempts > 0
                    ? InkWell(
                        onTap: () {
                          if (widget.maxAttempts > 0) {
                            widget.sendOTP();
                            setState(() {
                              widget.isOTPSent = true;
                              widget.isResend = true;
                              widget.timer = 120;
                              widget.maxAttempts--;
                            });
                            _startTimer();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Maximum OTP attempts reached.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child:
                            Text(widget.isResend ? 'Resend OTP' : 'Send OTP'),
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
          const Text(
            'Each OTP is valid for only 10 minutes.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: Dimensions.screenHeight / 46.6,
              left: Dimensions.screenWidth / 21.5,
              right: Dimensions.screenWidth / 21.5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => widget.verifyOTP(),
                  child: Container(
                    width: Dimensions.screenWidth / 2.15,
                    height: Dimensions.screenHeight / 18.64,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.lilacPurple,
                    ),
                    child: const Center(
                      child: Text(
                        'Verify',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
