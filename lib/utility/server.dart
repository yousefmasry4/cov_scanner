import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cov_scanner/constants.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:multipart_request/multipart_request.dart';

Future<String> get_ip() async {
  final data = await http.get(
      'https://raw.githubusercontent.com/yousefmasry4/cov_scanner/master/ip');
  return data.body;
}

