import 'dart:math';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:gita/Methods/Methods.dart';
import 'package:gita/Models/Chapters_Model.dart';
import 'package:gita/Screens/ChapterPage.dart';
import 'package:url_launcher/url_launcher.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage() : super();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GeetaChapters> _geetaChapters ;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Methods.getGeetaChapters().then((geetaChapters) {
      setState(() {
        _geetaChapters = geetaChapters;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(_loading ? 'Loading...' : 'श्रीमद् भगवद् गीता'),
        actions: [
          IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.brightness_2
                  : Icons.brightness_7_sharp),
              onPressed: () {
                AdaptiveTheme.of(context).toggleThemeMode();
              })
        ],
      ),
      drawer: Drawer(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.accents[Random().nextInt(15)],
                        blurRadius: 12.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                      image: AssetImage("images/1.jpg"),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                "bhagavadgītā\n[श्रीमद् भगवद् गीता]",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.orange),
              ),
              Text(
                "Gita - The Divine Song of God",
                style: TextStyle(fontSize: 16.0, color: Colors.orange),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'The Bhagavad Gita (Sanskrit: भगवद्गीता।, lit. "The Song of God"),\noften referred to as the Gita, is a 701-verse Hindu scripture that is part of the epic Mahabharata (chapters 23–40 of Bhishma Parva), dated to the second century BCE. It is considered to be one of the main holy scriptures for Hinduism.',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24.0,
              ),
              const SizedBox(
                height: 8.0,
              ),

              const SizedBox(
                height: 8.0,
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text("Developed with ❤️ in India  🇮🇳"),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      )),
      body: Container(
        child: _loading
            ? Center(
                child: SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: CircularProgressIndicator(
                    backgroundColor:  Colors.deepPurple,
                    strokeWidth: 4.0,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: null == _geetaChapters ? 0 : _geetaChapters.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionTile(
                        children: [
                          Text(
                            _geetaChapters[index].meaning.en,
                            textAlign: TextAlign.center,
                          ),
                          SelectableText(
                            _geetaChapters[index].meaning.hi,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          MaterialButton(
                            padding: EdgeInsets.all(12.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (BuildContext context) {
                                        return ChapterPage(
                                            ch: index + 1,
                                            chapters: _geetaChapters[index]);
                                      }));
                            },
                            color: Colors.orange,
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Text(
                              "Read Chapter - " + (index + 1).toString(),
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                        ],
                        title: Text(_geetaChapters[index].name),
                        subtitle: Text(_geetaChapters[index].translation),
                        leading: Text("  अध्याय  " + (index + 1).toString())),
                  );
                },
              ),
      ),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
