import 'dart:io';

// ignore: non_constant_identifier_names, missing_return
Future<bool> connection_test_fun()async{
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}