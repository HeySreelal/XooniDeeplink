import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xoonideeplink/screen/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _url;
  int _ix = 1;

  final FirebaseDynamicLinks links = FirebaseDynamicLinks.instance;

  String androidPackageName = "com.example.xoonideeplink";
  String iosBundleId = "com.example.xoonideeplink";
  void buildDynamicURL() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://xooni.page.link/',
      link: Uri.parse('https://www.example.com/users/user$_ix'),
      androidParameters: AndroidParameters(
        packageName: androidPackageName,
        minimumVersion: 1,
      ),
      iosParameters: IOSParameters(
        bundleId: iosBundleId,
        minimumVersion: '2',
      ),
    );

    final Uri uri = await links.buildLink(parameters);
    setState(() {
      _url = uri.toString();
    });
    _ix++;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      var path = dynamicLinkData.link.path;
      if (path.split('/')[1] == "users") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProfilePage(path.split("/").last);
        }));
      }
    }).onError((error) {
      // Handle errors
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Links'),
        centerTitle: true,
      ),
      body: Center(
        child: ListTile(
          title: Text(_url ?? "Create A Link First"),
          subtitle: Text(_url == null ? "" : "Tap to open."),
          onTap: () async {
            if (_url == null) return;
            try {
              launch(_url!);
            } catch (err) {
              print("Launch failed: $err");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: buildDynamicURL,
        child: const Icon(Icons.link),
      ),
    );
  }
}
