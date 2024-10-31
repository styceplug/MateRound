import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mate_round/utils/colors.dart';
import 'package:mate_round/utils/dimensions.dart';

class UploadAvatar extends StatefulWidget {
  final ValueChanged<File> onImageSelected;
  final File? selectedImage;
  final VoidCallback onUploadButtonPressed;

  const UploadAvatar({
    Key? key,
    required this.onImageSelected,
    required this.selectedImage,
    required this.onUploadButtonPressed,
  }) : super(key: key);

  @override
  _UploadAvatarState createState() => _UploadAvatarState();
}

class _UploadAvatarState extends State<UploadAvatar> {
  File? _imageFile;

  Future<void> _pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
        });
        widget.onImageSelected(_imageFile!);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Dimensions.screenHeight / 46.6,
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: Dimensions.screenWidth / 10.75,
          ),
          child: Center(
            child: Text(
              'Choosing a clear profile picture is crucial; it\'s your digital first impression. '
              'Clarity ensures you\'re easily recognizable, building trust and approachability for better online interactions.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Dimensions.screenHeight / 77.667,
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.screenHeight / 46.6,
        ),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: Dimensions.screenHeight / 2.663,
            width: Dimensions.screenWidth / 1.72,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: widget.selectedImage == null
                    ? const AssetImage('assets/images/upload_image.png')
                    : FileImage(widget.selectedImage!) as ImageProvider,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.screenHeight / 12.427,
        ),
        GestureDetector(
          onTap: widget.onUploadButtonPressed,
          child: Container(
            width: Dimensions.screenWidth / 2.15,
            height: Dimensions.screenHeight / 18.64,
            padding: EdgeInsets.symmetric(
              vertical: Dimensions.screenHeight / 93.2,
              horizontal: Dimensions.screenWidth / 43,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryColor,
            ),
            child: const Center(
              child: Text(
                'Upload Image',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
