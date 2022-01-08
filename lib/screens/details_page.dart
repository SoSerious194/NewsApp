import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String author;
  final String time;
  final String postUrl;

  const DetailsPage({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.author,
    required this.time,
    required this.postUrl,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> with AutomaticKeepAliveClientMixin {
  void _openLink(link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 22.0, right: 22.0, top: 22.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 22.0),
                      Text(
                        widget.title,
                        style: GoogleFonts.beVietnamPro(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.author + "  |  ",
                            style: GoogleFonts.beVietnamPro(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                          Text(
                            widget.time.substring(0, 10),
                            style: GoogleFonts.beVietnamPro(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22.0),
                      Text(
                        widget.description,
                        style: GoogleFonts.beVietnamPro(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 52.0),
                      GestureDetector(
                        onTap: () => _openLink(widget.postUrl),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                          child: Text(
                            "Click to read more",
                            style: GoogleFonts.beVietnamPro(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    @override
  bool get wantKeepAlive => true;

}
