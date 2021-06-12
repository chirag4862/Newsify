// import 'dart:convert';

// import 'package:xml2json/xml2json.dart';
// import 'package:http/http.dart' as http;

// Future<List> rssToJson(String category, {String baseUrl = 'https://www.hindustantimes.com/feeds/rss/'}) async {
//   var client = http.Client();
//   final myTranformer = Xml2Json();
//   return await client.get(baseUrl + category + "/rssfeed.xml").then((response) {
//     return response.body;
//   }).then((bodyString) {
//     myTranformer.parse(bodyString);
//     var json = myTranformer.toGData();
//     return jsonDecode(json)['rss']['channel']['item'];
//   });
// }

import 'dart:convert';

import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

Future<List> rssToJson(String category,
    {String baseUrl = 'https://www.hindustantimes.com/feeds/rss/'}) async {
  // var client = http.Client();
  final myTranformer = Xml2Json();
  var response = await http.get(Uri.parse(baseUrl + category + '/rssfeed.xml'));
  myTranformer.parse(response.body);
  var json = myTranformer.toGData();
  var result = jsonDecode(json)['rss']['channel']['item'];
  if (!(result is List<dynamic>)) {
    return [result];
  }
  return result;
}
