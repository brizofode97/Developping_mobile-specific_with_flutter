import 'package:flutter/material.dart';

import 'dart:convert';

class LessonListWidget extends StatefulWidget {
  const LessonListWidget({super.key});


  @override
  State<LessonListWidget> createState() {
    return _LessonList();
  }

}

class _LessonList extends State<LessonListWidget> {
  late Future<List<dynamic>> lessons;

  Future<List<dynamic>> fetchList() async {
    // await Future.delayed(Duration(seconds: 5));
    String s = await DefaultAssetBundle.of(context)
        .loadString('assets/config/lessons.json');
    return json.decode(s);
  }

  @override
  void initState() {
    super.initState();
    lessons = fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: lessons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dynamic? lessonInfo = snapshot.data;
            return ListView(
              children: <Widget>[
                // Should check that the type of glyph
                // is effectively a Map and contains the keys needed
                if (lessonInfo != null) for (var lesson in lessonInfo) ListTile(
                  leading: Text(lesson["code"],
                      style: const TextStyle(fontSize: 23.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey)),
                  title: Text(lesson["name"],
                      style: const TextStyle(fontSize: 11.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.blueAccent))
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error! Could not load lesson data!",
                  style: TextStyle(fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            );
          } else {
            return const Center(
              child: Text("Loading lesson data...",
                  style: TextStyle(fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            );
          }
        }
    );
  }

}
