import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelector extends StatefulWidget {
  final void Function(String selectImage) onImageSelect;
  const ImageSelector({super.key, required this.onImageSelect});

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  File? pickedImage;
  Future<void> _pickImage() async {
    final ImagePicker piker = ImagePicker();
    XFile? image = await piker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
        widget.onImageSelect(pickedImage.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _pickImage();
      },
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade400,
            backgroundImage:
                pickedImage != null ? FileImage(pickedImage!) : null,
            radius: 65,
          ),
          if (pickedImage == null)
            const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              backgroundImage: AssetImage("assets/image/user.png"),
              radius: 60,
            ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Image.asset(
              "assets/icons/camera.png",
              width: 32,
              height: 32,
            ),
          ),
        ],
      ),
    );
  }
}
