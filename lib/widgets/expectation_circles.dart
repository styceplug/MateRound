import 'package:flutter/material.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

abstract class ExpectationCircle extends StatefulWidget {
  final int id;
  final String title;
  final Color? color;
  final void Function(bool isSelected) onTap;

  const ExpectationCircle({
    required this.id,
    required this.title,
    this.color,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  double get size;
  double get textSize;

  @override
  _ExpectationCircleState createState() => _ExpectationCircleState();
}

class _ExpectationCircleState extends State<ExpectationCircle> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onTap(isSelected);
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? AppColors.lilacPurple
              : widget.color ?? Colors.grey[300],
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.cover,
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: widget.textSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Level1Circle extends ExpectationCircle {
  const Level1Circle({super.key,
    required int id,
    required String title,
    Color? color,
    required void Function(bool isSelected) onTap,
  }) : super(id: id, title: title, color: color, onTap: onTap);

  @override
  double get size => Dimensions.screenHeight / 14.338;
  @override
  double get textSize => Dimensions.screenHeight / 93.2;
}

class Level2Circle extends ExpectationCircle {
  const Level2Circle({super.key,
    required int id,
    required String title,
    Color? color,
    required void Function(bool isSelected) onTap,
  }) : super(id: id, title: title, color: color, onTap: onTap);

  @override
  double get size => Dimensions.screenHeight / 9.32;
  @override
  double get textSize => Dimensions.screenHeight / 66.571;
}

class Level3Circle extends ExpectationCircle {
  const Level3Circle({super.key,
    required int id,
    required String title,
    Color? color,
    required void Function(bool isSelected) onTap,
  }) : super(id: id, title: title, color: color, onTap: onTap);

  @override
  double get size => Dimensions.screenHeight / 6.6571;
  @override
  double get textSize => Dimensions.screenHeight / 58.25;
}
