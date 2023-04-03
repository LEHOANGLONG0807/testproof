import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:demoproof/senimage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: Page.pages,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.proof,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final time = DateTime.now().millisecondsSinceEpoch.toString();

  final _url = RxnString();

  final uint8List = Rxn<Uint8List>();

  late DatabaseReference starCountRef;

  @override
  void initState() {
    starCountRef = FirebaseDatabase.instance.ref(time);
    super.initState();
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        _url.value = data['url'];
        uint8List.value = _getImageBinary(jsonDecode(data['byte']));
        Get.snackbar('url', _url.value ?? '--null');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo proof'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return Container(
                width: 300,
                height: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                child: uint8List.value != null
                    ? Image.memory(uint8List.value!)
                    : const Text('Upload Proof'),
              );
            }),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              if (_url.value != null) {
                return InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: _url.value ?? ''));
                  },
                  child: Text(
                    _url.value ?? '',
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return const SizedBox();
            }),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.upload, parameters: {'key': time});
                },
                child: Text('cjdcnjdnc')),
            QrImage(
              data: 'https://testproof.vercel.app/#/proof/upload?key=$time',
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Uint8List _getImageBinary(dynamicList) {
    List<int> intList = dynamicList.cast<int>().toList(); //This is the magical line.
    Uint8List data = Uint8List.fromList(intList);
    return data;
  }
}

abstract class Routes {
  static const upload = '/proof/upload';
  static const proof = '/proof';
}

abstract class Page {
  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: Routes.upload,
      transition: Transition.noTransition,
      page: () => const SendImageScreen(),
    ),
    GetPage(
      name: Routes.proof,
      transition: Transition.noTransition,
      page: () => const MyHomePage(title: 'title'),
    ),
  ];
}
