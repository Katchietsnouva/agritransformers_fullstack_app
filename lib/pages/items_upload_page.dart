import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // Import the dart:io library

// ignore: unused_import
// import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

class ItemsUploadScreen extends StatefulWidget {
  const ItemsUploadScreen({super.key});

  // const ItemsUploadScreen({super.key});
  // const ItemsUploadScreen({Key? key}) : super(key: key);

  @override
  State<ItemsUploadScreen> createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  String? imagePath; // Declare imagePath here

  Uint8List? imageFileUint8List;

  TextEditingController sellerNameTextEditingController =
      TextEditingController();
  TextEditingController sellerPhoneTextEditingController =
      TextEditingController();
  TextEditingController itemNameTextEditingController = TextEditingController();
  TextEditingController itemDescriptionTextEditingController =
      TextEditingController();
  TextEditingController itemPriceTextEditingController =
      TextEditingController();

  bool isUploading = false;

  //upload form screen

  Widget uploadFormScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Upload New Item',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.cloud_upload,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      // Upload Progress Bar
      body: ListView(
        children: [
          isUploading == true
              ? const LinearProgressIndicator(
                  color: Colors.purpleAccent,
                )
              : Container(),

          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: imageFileUint8List != null
                  ? Image.memory(imageFileUint8List!)
                  : imagePath != null
                      ? Image.file(File(imagePath!)) // Use File from dart:io
                      : const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 40,
                        ),
            ),
          ),

          // DIVIDER
          const Divider(
            color: Colors.white70,
            thickness: 2,
          ),

          // SELLER NAME
          ListTile(
            leading: const Icon(
              Icons.person_pin_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: sellerNameTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Seller name',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),

          // SELLER PHONE
          ListTile(
            leading: const Icon(
              Icons.phone_iphone_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: sellerPhoneTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Seller phone number',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),

          // ITEM NAME
          ListTile(
            leading: const Icon(
              Icons.title,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: itemNameTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Item name',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),

          // ITEM DESCRIPTION
          ListTile(
            leading: const Icon(
              Icons.description_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: itemDescriptionTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Item Description',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),

          // ITEM PRICE
          ListTile(
            leading: const Icon(
              Icons.price_change_rounded,
              color: Colors.white,
            ),
            title: SizedBox(
              width: 250,
              child: TextField(
                style: const TextStyle(color: Colors.grey),
                controller: itemPriceTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Item price',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const Divider(
            color: Colors.white70,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  //default screen
  Widget defaultScreen() {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text(
            'Upload New Item',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_photo_alternate,
                color: Colors.white,
                size: 200,
              ),
              ElevatedButton(
                onPressed: () {
                  showDialogbox();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black54,
                ),
                child: const Text(
                  'Add New Item',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  showDialogbox() {
    return showDialog(
        context: context,
        builder: (c) {
          return SimpleDialog(
            backgroundColor: Colors.black,
            title: const Text(
              'Item Image',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  captureImageWithWebPhoneCamera();
                },
                child: const Text(
                  'Capture image with Camera',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  chooseImageFromGallery();
                },
                child: const Text(
                  'Choose image from Gallery',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  openWindowsGallery();
                },
                child: const Text(
                  'Choose image from Windows Gallery',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          );
        });
  }

  captureImageWithWebPhoneCamera() async {
    Navigator.pop(context);
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();

        //remove background from imagae or make background transparent
        setState(() {
          imageFileUint8List;
        });
      }
    } catch (errorMsg) {
      // ignore: avoid_print
      print(errorMsg.toString());
      setState(() {
        imageFileUint8List = null;
      });
    }
  }

  chooseImageFromGallery() async {
    Navigator.pop(context);
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();

        //remove background from imagae or make background transparent
        setState(() {
          imageFileUint8List;
        });
      }
    } catch (errorMsg) {
      // ignore: avoid_print
      print(errorMsg.toString());
      setState(() {
        imageFileUint8List = null;
      });
    }
  }

  Future<void> openWindowsGallery() async {
  try {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Specify the file type you want to pick (e.g., image, video, any)
    );

    if (result != null) {
      for (final file in result.files) {
        final imagePath = file.path; // Get the selected image's path

        final uint8List = Uint8List.fromList(file.bytes!); // Read the bytes

        if (uint8List.isNotEmpty) {
          // Now you have the image path in 'imagePath' and its bytes in 'uint8List'

          setState(() {
            imageFileUint8List = uint8List;
          });

          // If you want to display the image directly in your UI, you can use the Image.memory widget.
          // For example, you can add it below your ListTile in the uploadFormScreen widget:
          // Just make sure to update your UI when the image changes.
        } else {
          // Handle the case where the bytes are empty (no bytes read)
          // For example, display an error message or handle the situation as needed.
        }
      }
    } else {
      // User canceled the file picker
    }
  } catch (e) {
    // Handle any potential exceptions
    print("Error: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return imageFileUint8List == null ? defaultScreen() : uploadFormScreen();
  }
}
