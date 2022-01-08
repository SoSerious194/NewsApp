import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/services/news_api.dart';

import 'details_page.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage>
    with AutomaticKeepAliveClientMixin {
  NewsAPI newsAPI = NewsAPI();
  List health = [];
  
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
        await newsAPI.getHealth(_page.toString());
        health.addAll(newsAPI.health);
      } catch (err) {
        print('Something went wrong!');
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  Future<void> getData() async {
    await newsAPI.getHealth(_page.toString());
    health = newsAPI.health;
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
                  controller: _controller,
                    itemCount: health.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                imageUrl: health[index].imageUrl,
                                title: health[index].title,
                                description: health[index].description,
                                author: health[index].author,
                                time: health[index].time,
                                postUrl: health[index].postUrl,
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
                                    imageUrl: health[index].imageUrl,
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
                                      health[index].title.toString().length > 50
                                          ? health[index].title.substring(0, 50) +
                                              "..."
                                          : health[index].title,
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
                                          health[index].author.toString().length > 20
                                              ? health[index]
                                                      .author
                                                      .substring(0, 20) +
                                                  "..."
                                              : health[index].author,
                                          style: GoogleFonts.beVietnamPro(
                                            fontSize: 10.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            health[index].time.substring(0, 10),
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
