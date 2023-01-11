import 'package:flutter/material.dart';

import 'glyph_list.dart';
import 'lesson_list.dart';
import 'community.dart';
import 'contact.dart';

void main() {
  runApp(const GlobomanticsTabHome());
}

class GlobomanticsTabHome extends StatelessWidget {
  const GlobomanticsTabHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.toc)),
                Tab(icon: Icon(Icons.school)),
                Tab(icon: Icon(Icons.connect_without_contact)),
                Tab(icon: Icon(Icons.mail_outline)),
              ],
            ),
            title: const Text('Globoscript'),
          ),
          body: const TabBarView(
            children: [
              GlyphListWidget(),
              LessonListWidget(),
              CommunityWidget(),
              ContactWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
