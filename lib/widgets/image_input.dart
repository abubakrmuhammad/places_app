import 'dart:io';

import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

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
              onPressed: () {},
            ),
          ),
        )
      ],
    );
  }
}
