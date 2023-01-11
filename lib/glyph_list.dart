import 'package:flutter/material.dart';

import 'dart:convert';

class GlyphListWidget extends StatefulWidget {
  const GlyphListWidget({super.key});


  @override
  State<GlyphListWidget> createState() {
    return _GlyphList();
  }

}

class _GlyphList extends State<GlyphListWidget> {
  late Future<List<dynamic>> glyphs;

  Future<List<dynamic>> fetchList() async {
    //await Future.delayed(Duration(seconds: 5));
    String s = await DefaultAssetBundle.of(context)
        .loadString('assets/config/glyphs.json');
    return json.decode(s);
  }

  @override
  void initState() {
    super.initState();
    glyphs = fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: glyphs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dynamic? glyphInfo = snapshot.data;
            return ListView(
              children: <Widget>[
                // Should check that the type of glyph
                // is effectively a Map and contains the keys needed
                if (glyphInfo != null) for (var glyph in glyphInfo) ListTile(
                  leading: Text(glyph["glyph"],
                      style: const TextStyle(fontSize: 39.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey)),
                  title: Text(glyph["info"],
                      style: const TextStyle(fontSize: 11.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.blueAccent))
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error! Could not load glyph data!",
                  style: TextStyle(fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            );
          } else {
            return const Center(
              child: Text("Loading glyph data...",
                  style: TextStyle(fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            );
          }
        }
    );
  }

}
