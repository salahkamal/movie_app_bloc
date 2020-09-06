import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';




class HttpClient {


   Future <dynamic> fetchData(String url) async {

    var response = await HttpUtils.getForJson(url);

      return response;

  }



}




