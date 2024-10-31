import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

class UpdateInfo extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final TextEditingController bioController;
  final TextEditingController birthdayController;
  final ValueChanged<DateTime> onBirthdayChanged;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<String?> onHeightChanged;
  final ValueChanged<String?> onHairColorChanged;
  final VoidCallback onSubmit;

  const UpdateInfo({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.bioController,
    required this.birthdayController,
    required this.onBirthdayChanged,
    required this.onGenderChanged,
    required this.onHeightChanged,
    required this.onHairColorChanged,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // first and last name
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: firstNameController,
                    style: TextStyle(
                      fontSize: Dimensions.screenHeight / 62.133,
                      color: AppColors.text,
                    ),
                    cursorColor: AppColors.primaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'First Name',
                      labelStyle: TextStyle(
                        fontSize: Dimensions.font14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.primaryColor,
                      ),
                      hintText: 'Input First Name',
                      hintStyle: TextStyle(
                        fontSize: Dimensions.font14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.text.withOpacity(0.5),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.width5 / Dimensions.width10,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.width5 / Dimensions.width10,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Dimensions.width20),
                Expanded(
                  child: TextField(
                    controller: lastNameController,
                    style: TextStyle(
                      fontSize: Dimensions.screenHeight / 62.133,
                      color: AppColors.text,
                    ),
                    cursorColor: AppColors.primaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Last Name',
                      labelStyle: TextStyle(
                        fontSize: Dimensions.font14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.primaryColor,
                      ),
                      hintText: 'Input Last Name',
                      hintStyle: TextStyle(
                        fontSize: Dimensions.font14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.text.withOpacity(0.5),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.width5 / Dimensions.width10,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.width5 / Dimensions.width10,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // username
            SizedBox(height: Dimensions.height20),
            TextField(
              controller: usernameController,
              style: TextStyle(
                fontSize: Dimensions.screenHeight / 62.133,
                color: AppColors.text,
              ),
              cursorColor: AppColors.primaryColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: 'Select Username',
                labelStyle: TextStyle(
                  fontSize: Dimensions.font14,
                  fontWeight: FontWeight.w300,
                  color: AppColors.primaryColor,
                ),
                hintText: 'Input Username',
                hintStyle: TextStyle(
                  fontSize: Dimensions.font14,
                  fontWeight: FontWeight.w300,
                  color: AppColors.text.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: Dimensions.width5 / Dimensions.width10,
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: Dimensions.width5 / Dimensions.width10,
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                ),
              ),
            ),
            Text(
              'Username cannot contain spaces.',
              style: TextStyle(
                color: Colors.black.withOpacity(0.3),
                fontSize: Dimensions.font13,
              ),
            ),
            // height and hair color
            SizedBox(height: Dimensions.height10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: false,
                    isDense: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width20,
                          vertical: Dimensions.height10),
                      hintText: '',
                      hintStyle: TextStyle(
                        fontSize: Dimensions.font16,
                        fontWeight: FontWeight.w300,
                        color: AppColors.text.withOpacity(0.5),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.width5 / Dimensions.width10,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.width5 / Dimensions.width10,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                    ),
                    hint: Center(
                      child: Text(
                        'Height',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                    ),
                    items: List.generate(
                      49,
                      (index) {
                        int feet = 4 + index ~/ 12;
                        int inches = index % 12;
                        String height = '$feet\'$inches\'\'';
                        return DropdownMenuItem(
                          value: height,
                          child: Text(height),
                        );
                      },
                    ),
                    onChanged: onHeightChanged,
                  ),
                ),
                SizedBox(width: Dimensions.width20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: false,
                    isDense: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width20,
                          vertical: Dimensions.height10),
                      hintText: '',
                      hintStyle: TextStyle(
                        fontSize: Dimensions.font16,
                        fontWeight: FontWeight.w300,
                        color: AppColors.text.withOpacity(0.5),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.width5 / Dimensions.width10,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.width5 / Dimensions.width10,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                    ),
                    hint: Center(
                      child: Text(
                        'Hair Color',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                    ),
                    items: [
                      'Black',
                      'Brown',
                      'Blonde',
                      'Red',
                      'Grey',
                      'Other',
                    ].map((color) {
                      return DropdownMenuItem(
                        value: color,
                        child: Text(color),
                      );
                    }).toList(),
                    onChanged: onHairColorChanged,
                  ),
                ),
              ],
            ),
            // gender and birthday
            SizedBox(height: Dimensions.height10),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    isExpanded: false,
                    isDense: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width20,
                          vertical: Dimensions.height10),
                      hintText: '',
                      hintStyle: TextStyle(
                        fontSize: Dimensions.font16,
                        fontWeight: FontWeight.w300,
                        color: AppColors.text.withOpacity(0.5),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.width5 / Dimensions.width10,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.width5 / Dimensions.width10,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                    ),
                    hint: Center(
                      child: Text(
                        'Select Gender',
                        style: TextStyle(
                          fontSize: Dimensions.font16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ),
                    ),
                    items: [
                      'Male',
                      'Female',
                      'Non-binary',
                      'Other',
                    ].map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: onGenderChanged,
                  ),
                ),
                SizedBox(width: Dimensions.width20),
                Expanded(
                  child: TextField(
                    controller: birthdayController,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        birthdayController.text =
                            formattedDate; // set output date to TextField value
                        onBirthdayChanged(pickedDate);
                      }
                    },
                    style: TextStyle(
                      fontSize: Dimensions.screenHeight / 62.133,
                      color: AppColors.text,
                    ),
                    cursorColor: AppColors.primaryColor,
                    readOnly: true,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Birthday',
                      labelStyle: TextStyle(
                        fontSize: Dimensions.font14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.primaryColor,
                      ),
                      hintText: 'Select Birthday',
                      hintStyle: TextStyle(
                        fontSize: Dimensions.font14,
                        fontWeight: FontWeight.w300,
                        color: AppColors.text.withOpacity(0.5),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.width5 / Dimensions.width10,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: Dimensions.width5 / Dimensions.width10,
                          color: AppColors.primaryColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // bio
            SizedBox(height: Dimensions.height20),
            TextField(
              controller: bioController,
              maxLines: 5,
              style: TextStyle(
                fontSize: Dimensions.screenHeight / 62.133,
                color: AppColors.text,
              ),
              cursorColor: AppColors.primaryColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: 'Bio',
                labelStyle: TextStyle(
                  fontSize: Dimensions.font14,
                  fontWeight: FontWeight.w300,
                  color: AppColors.primaryColor,
                ),
                hintText: 'Tell us about yourself...',
                hintStyle: TextStyle(
                  fontSize: Dimensions.font14,
                  fontWeight: FontWeight.w300,
                  color: AppColors.text.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: Dimensions.width5 / Dimensions.width10,
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: Dimensions.width5 / Dimensions.width10,
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height20),
            // submit button
            Container(
              width: double.infinity,
              height: Dimensions.height50,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius10),
              ),
              child: TextButton(
                onPressed: onSubmit,
                child: Text(
                  'Update Info',
                  style: TextStyle(
                    fontSize: Dimensions.font16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
