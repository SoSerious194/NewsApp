import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/details_page.dart';
import 'package:news_app/services/news_api.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({Key? key}) : super(key: key);

  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage>
    with AutomaticKeepAliveClientMixin {
  NewsAPI newsAPI = NewsAPI();
  List topheadlines = [];
  List general = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await newsAPI.getTopHeadlines();
    await newsAPI.getGeneral();
    topheadlines = newsAPI.headlines;
    general = newsAPI.general;
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 22.0),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const SizedBox(height: 12.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top Headlines",
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 22.0),
                Expanded(
                  flex: 1,
                  child: CarouselSlider.builder(
                    itemCount: topheadlines.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            imageUrl: topheadlines[itemIndex].imageUrl,
                            title: topheadlines[itemIndex].title,
                            description: topheadlines[itemIndex].description,
                            author: topheadlines[itemIndex].author,
                            time: topheadlines[itemIndex].time,
                            postUrl: topheadlines[itemIndex].postUrl,
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: CachedNetworkImage(
                              imageUrl: topheadlines[itemIndex].imageUrl,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: double.infinity,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                value: downloadProgress.progress,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                ),
                                color: Colors.black.withAlpha(85),
                              ),
                              child: Text(
                                topheadlines[itemIndex]
                                            .title
                                            .toString()
                                            .length >
                                        50
                                    ? topheadlines[itemIndex]
                                            .title
                                            .substring(0, 50) +
                                        "..."
                                    : topheadlines[itemIndex].title,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      aspectRatio: 2.0,
                      initialPage: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 22.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "General",
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 22.0),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: general.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                imageUrl: general[index].imageUrl,
                                title: general[index].title,
                                description: general[index].description,
                                author: general[index].author,
                                time: general[index].time,
                                postUrl: general[index].postUrl,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 100.0,
                          margin: const EdgeInsets.only(bottom: 12.0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 2.0,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            color: Colors.white70,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: general[index].imageUrl,
                                    fit: BoxFit.cover,
                                    width: 140,
                                    height: 40,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 18.0,
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      general[index].title.toString().length >
                                              50
                                          ? general[index]
                                                  .title
                                                  .substring(0, 50) +
                                              "..."
                                          : general[index].title,
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          general[index]
                                                      .author
                                                      .toString()
                                                      .length >
                                                  20
                                              ? general[index]
                                                      .author
                                                      .substring(0, 20) +
                                                  "..."
                                              : general[index].author,
                                          style: GoogleFonts.beVietnamPro(
                                            fontSize: 10.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            general[index]
                                                .time
                                                .substring(0, 10),
                                            style: GoogleFonts.beVietnamPro(
                                              fontSize: 10.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
