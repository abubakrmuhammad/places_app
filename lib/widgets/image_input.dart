import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  final Function selectImage;
  const ImageInput(this.selectImage, {Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _takePicture() async {
    final imageXFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageXFile == null) return;
    final imageFile = File(imageXFile.path);

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');

    widget.selectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          alignment: Alignment.center,
          child: _storedImage == null
              ? const Text(
                  'No Image Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _storedImage!,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: TextButton.icon(
              icon: const Icon(Icons.camera),
              label: const Text('Select Image'),
              onPressed: _takePicture,
            ),
          ),
        )
      ],
    );
  }
}
