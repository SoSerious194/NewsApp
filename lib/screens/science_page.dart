import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/services/news_api.dart';

import 'details_page.dart';

class SciencePage extends StatefulWidget {
  const SciencePage({Key? key}) : super(key: key);

  @override
  _SciencePageState createState() => _SciencePageState();
}

class _SciencePageState extends State<SciencePage> with AutomaticKeepAliveClientMixin {
  NewsAPI newsAPI = NewsAPI();
  List science = [];
  
    bool isLoading = true;
  bool _isLoadMoreRunning = false;
  bool _hasNextPage = true;

  int _page = 1;
  int _limit = 20;

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_loadMore);
    getData();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  void _loadMore() async {
    if (_hasNextPage == true &&
        isLoading == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        await newsAPI.getScience(_page.toString());
        science.addAll(newsAPI.science);
      } catch (err) {
        print('Something went wrong!');
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  Future<void> getData() async {
    await newsAPI.getScience(_page.toString());
    science = newsAPI.science;
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
              Expanded(
                child: ListView.builder(
                    itemCount: science.length,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                imageUrl: science[index].imageUrl,
                                title: science[index].title,
                                description: science[index].description,
                                author: science[index].author,
                                time: science[index].time,
                                postUrl: science[index].postUrl,
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
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            color: Colors.white70,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: science[index].imageUrl,
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
                                      science[index].title.toString().length > 50
                                          ? science[index].title.substring(0, 50) +
                                              "..."
                                          : science[index].title,
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
                                          science[index].author.toString().length > 20
                                              ? science[index]
                                                      .author
                                                      .substring(0, 20) +
                                                  "..."
                                              : science[index].author,
                                          style: GoogleFonts.beVietnamPro(
                                            fontSize: 10.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            science[index].time.substring(0, 10),
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
              if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
            ],
          ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
