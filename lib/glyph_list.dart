import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';

class GlyphListWidget extends StatefulWidget {
  const GlyphListWidget({super.key});

  @override
  State<GlyphListWidget> createState() {
    return _GlyphList();
  }
}

class _GlyphList extends State<GlyphListWidget> {
  late Future<List<dynamic>> glyphs;

  //late AudioCache _audioCache;
  final List<String> route = [
    'audio/glyphs/a.mp3',
    'audio/glyphs/e.mp3',
    'audio/glyphs/i.mp3',
    'audio/glyphs/o.mp3',
    'audio/glyphs/u.mp3',
  ];
  final player = AudioPlayer();
  int i = 0;

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

    //_audioCache =  AudioCache(prefix: "assets/audio/glyphs/", fixedPlayer: AudioPlayer());
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
                if (glyphInfo != null)
                  for (var glyph in glyphInfo)
                    ListTile(
                        leading: Text(glyph["glyph"],
                            style: const TextStyle(
                                fontSize: 39.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey)),
                        title: Text(glyph["info"],
                            style: const TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.blueAccent)),
                        trailing: IconButton(
                          color: Colors.orange,
                          icon: const Icon(Icons.play_circle_outline),
                          onPressed: () => _playShortSound("audio/glyphs/${glyph["audio"]}") ,
                        )),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error! Could not load glyph data!",
                  style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            );
          } else {
            return const Center(
              child: Text("Loading glyph data...",
                  style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            );
          }
        });
  }

  void _playShortSound(String asset) {
    player.stop();
    // ignore: unrelated_type_equality_checks
    if(player.state != 0){
      player.play(AssetSource(asset));
    }
  }
}
