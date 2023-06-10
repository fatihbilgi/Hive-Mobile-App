import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../Utils/Utils.dart';


class Request {
  final String url;
  final dynamic body;

  Request({required this.url, this.body});

  Future<String> post(String token) async{
    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(urlBase+url));
    request.headers.set('content-type', 'application/json');
    if(token != null || token != ""){
      request.headers.set('Authorization', token);

    }


    request.add(utf8.encode(body));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }
  Future<String> get(String token)async {
    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(urlBase+url));
    request.headers.set('content-type', 'application/json');
    if(token != null || token != "")
      request.headers.set('Authorization', token);
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }
}