import 'package:flutter/material.dart';
import 'package:news_app/screens/business_page.dart';
import 'package:news_app/screens/entertainment_page.dart';
import 'package:news_app/screens/health_page.dart';
import 'package:news_app/screens/science_page.dart';
import 'package:news_app/screens/sports_page.dart';
import 'package:news_app/screens/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            "News App",
            style: GoogleFonts.beVietnamPro(
              fontSize: 22.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Home"),
              Tab(text: "Sports"),
              Tab(text: "Entertainment"),
              Tab(text: "Business"),
              Tab(text: "Science"),
              Tab(text: "Health"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TrendingPage(),
            SportsPage(),
            EntertainmentPage(),
            BusinessPage(),
            SciencePage(),
            HealthPage(),
          ],
        ),
      ),
    );
  }
}
