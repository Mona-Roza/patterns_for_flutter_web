// ignore: avoid_web_libraries_in_flutter
import 'dart:html' show FileReader, FileUploadInputElement;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:patterns_for_flutter_web/firebase_storage/storage_service.dart';

class StorageView extends StatefulWidget {
  const StorageView({Key? key}) : super(key: key);

  @override
  _StorageViewState createState() => _StorageViewState();
}

class _StorageViewState extends State<StorageView> {
  final Future<FirebaseApp> _initialization = (Firebase.initializeApp());

  final StorageService _storageservice = StorageService();
  var imageUrl = '';

  uploadToStorage() {
    FileUploadInputElement input = FileUploadInputElement()..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      final file = input.files?.first;
      final reader = FileReader();
      reader.readAsDataUrl(file!);
      reader.onLoadEnd.listen((event) async {
        var downloadUrl = await _storageservice.pickImage(file);
        setState(() {
          imageUrl = downloadUrl;
          debugPrint("2. imageUrl: $imageUrl\ndownloadUrl: $downloadUrl");
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            double _screenwidth = MediaQuery.of(context).size.width;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Pick And Post The Server"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 500,
                      width: _screenwidth,
                      color: Colors.blue.shade200,
                      child: imageUrl == ''
                          ? const Center(
                              child: Text('Henüz fotoğraf yüklemediniz'),
                            )
                          : SizedBox(child: Image.network(imageUrl)),
                    ),
                    const SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () => uploadToStorage(),
                      color: Colors.red,
                      child: const Text('Upload'),
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
