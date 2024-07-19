import 'package:flutter/material.dart';
import 'package:mate_round/utils/colors.dart';

class RememberMeCheckbox extends StatefulWidget {
  final ValueChanged<bool> onChanged;

  const RememberMeCheckbox({Key? key, required this.onChanged})
      : super(key: key);

  @override
  _RememberMeCheckboxState createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  bool _isChecked = false;

  void _onChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _isChecked,
      onChanged: (bool? value) {
        _onChanged(value!);
      },
      checkColor: AppColors.mainPurple,
      activeColor: Colors.white,
    );
  }
}
