import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SearchProvider extends ChangeNotifier {
  bool searching = false;
  String error = '';
  Map responseBody = {};
  List results;
  search({String searchString}) async {
    searching = true;
    notifyListeners();
    if (searchString.isNotEmpty) {
      Response response = await get(
        'http://www.omdbapi.com/?s=${searchString.trim()}&apikey=de9c0d08',
      );
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
        results = responseBody['Search'];
        print(responseBody);
        if (responseBody['Response'] == 'True')
          updateRating();
        else {
          results = [];
          searching = false;
          notifyListeners();
        }
      }
    } else {
      results = [];
      searching = false;
      notifyListeners();
    }
  }

  getRatings(Map data) async {
    String title = data['imdbID'];
    Response response = await get(
      "http://www.omdbapi.com/?i=$title&apikey=de9c0d08",
    );
    if (response.statusCode == 200) {
      Map body = jsonDecode(response.body);
      data['genre'] = body['Genre'];
      return body['imdbRating'];
    }

    return null;
  }

  updateRating() async {
    for (var i = 0; i < results.length; i++) {
      results[i]['rating'] = await getRatings(results[i]);
    }
    searching = false;
    notifyListeners();
  }
}
