import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/business.dart';
import 'package:news_app/models/entertainment.dart';
import 'package:news_app/models/general.dart';
import 'package:news_app/models/health.dart';
import 'package:news_app/models/science.dart';
import 'package:news_app/models/sports.dart';
import 'package:news_app/models/top_headlines.dart';

class NewsAPI {
  List<TopHeadlines> headlines = [];
  List<General> general = [];
  List<Sports> sports = [];
  List<Entertainment> entertainment = [];
  List<Business> business = [];
  List<Science> science = [];
  List<Health> health = [];

  Future<void> getTopHeadlines() async {
    var apiKey = "44594053cde3434e83b58358a8980f4d";
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey");
    final response = await http.get(url);
    var decode = jsonDecode(response.body);
    decode['articles'].forEach((element) {
      if (element['urlToImage'] != null && element['author'] != null && element['description'] != null) {
        TopHeadlines topHeadlines = TopHeadlines(
          element['author'],
          element['title'],
          element['description'],
          element['urlToImage'],
          element['url'],
          element['publishedAt']
        );
        headlines.add(topHeadlines);
      }
    });
  }

  Future<void> getGeneral() async {
    var apiKey = "44594053cde3434e83b58358a8980f4d";
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=general&apiKey=$apiKey");
    final response = await http.get(url);
    var decode = jsonDecode(response.body);
    decode['articles'].forEach((element) {
      if (element['urlToImage'] != null && element['author'] != null && element['description'] != null) {
        General topGeneral = General(
          element['author'],
          element['title'],
          element['description'],
          element['urlToImage'],
          element['url'],
          element['publishedAt']
        );
        general.add(topGeneral);
      }
    });
  }

  Future<void> getSports(String page) async {
    var apiKey = "44594053cde3434e83b58358a8980f4d";
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&page=$page&category=sports&apiKey=$apiKey");
    final response = await http.get(url);
    var decode = jsonDecode(response.body);
    decode['articles'].forEach((element) {
      if (element['urlToImage'] != null && element['author'] != null && element['description'] != null) {
        Sports topSports = Sports(
          element['author'],
          element['title'],
          element['description'],
          element['urlToImage'],
          element['url'],
          element['publishedAt']
        );
        sports.add(topSports);
      }
    });
  }

  Future<void> getEntertainment(String page) async {
    var apiKey = "44594053cde3434e83b58358a8980f4d";
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&page=$page&category=entertainment&apiKey=$apiKey");
    final response = await http.get(url);
    var decode = jsonDecode(response.body);
    decode['articles'].forEach((element) {
      if (element['urlToImage'] != null && element['author'] != null && element['description'] != null) {
        Entertainment topEntertainment = Entertainment(
          element['author'],
          element['title'],
          element['description'],
          element['urlToImage'],
          element['url'],
          element['publishedAt']
        );
        entertainment.add(topEntertainment);
      }
    });
  }

  Future<void> getBusiness(String page) async {
    var apiKey = "44594053cde3434e83b58358a8980f4d";
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&page=$page&category=business&apiKey=$apiKey");
    final response = await http.get(url);
    var decode = jsonDecode(response.body);
    decode['articles'].forEach((element) {
      if (element['urlToImage'] != null && element['author'] != null && element['description'] != null) {
        Business topBusiness = Business(
          element['author'],
          element['title'],
          element['description'],
          element['urlToImage'],
          element['url'],
          element['publishedAt']
        );
        business.add(topBusiness);
      }
    });
  }

  Future<void> getScience(String page) async {
    var apiKey = "44594053cde3434e83b58358a8980f4d";
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&page=$page&category=science&apiKey=$apiKey");
    final response = await http.get(url);
    var decode = jsonDecode(response.body);
    decode['articles'].forEach((element) {
      if (element['urlToImage'] != null && element['author'] != null && element['description'] != null) {
        Science topScience = Science(
          element['author'],
          element['title'],
          element['description'],
          element['urlToImage'],
          element['url'],
          element['publishedAt']
        );
        science.add(topScience);
      }
    });
  }

  Future<void> getHealth(String page) async {
    var apiKey = "44594053cde3434e83b58358a8980f4d";
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&page=$page&category=health&apiKey=$apiKey");
    final response = await http.get(url);
    var decode = jsonDecode(response.body);
    decode['articles'].forEach((element) {
      if (element['urlToImage'] != null && element['author'] != null && element['description'] != null) {
        Health topHealth = Health(
          element['author'],
          element['title'],
          element['description'],
          element['urlToImage'],
          element['url'],
          element['publishedAt']
        );
        health.add(topHealth);
      }
    });
  }

}
