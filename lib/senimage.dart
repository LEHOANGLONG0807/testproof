import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SendImageScreen extends StatefulWidget {
  const SendImageScreen({Key? key}) : super(key: key);

  @override
  SendImageScreenState createState() => SendImageScreenState();
}

class SendImageScreenState extends State<SendImageScreen> {
  XFile? _file;

  late String _time;

  void _incrementCounter() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _file = pickedFile;
      });
    }
  }

  @override
  void initState() {
    if (Get.parameters.isNotEmpty) {
      _time = Get.parameters['key']!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Proof'),
      ),
      body: Center(
        child: _file != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: FutureBuilder<Uint8List>(
                        future: _file!.readAsBytes(),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return Image.memory(snapshot.data!);
                          }
                          return const CircularProgressIndicator();
                        }),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        uploadFile(_file!, _time);
                      },
                      child: const Text('Send')),
                ],
              )
            : const SizedBox(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<String?> uploadFile(XFile image, String ref) async {
    try {
      String nameImage = DateTime.now().millisecondsSinceEpoch.toString();

      Reference reference = FirebaseStorage.instance.ref(ref).child('images/$nameImage.png');
      await reference.putData(
        await image.readAsBytes(),
        SettableMetadata(contentType: 'image/png'),
      );
      final newUrl = await reference.getDownloadURL();
      final refDTB = FirebaseDatabase.instance.ref(ref);

      await refDTB.set({"url": newUrl});
      Get.snackbar('Success', 'Upload success');
      return newUrl;
    } catch (e) {
      Get.snackbar('Error', e.toString());
      return null;
    }
  }
}
