import 'package:fooddeliveryapp/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String
      token; //when you talk to teh server you should have a token that should be initialized within apiclient
  final String appBaseUrl; //url of the app that talks to the server
  // ignore: unused_field
  late Map<String, String> _mainHeaders;
  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    token = AppConstansts.TOKEN;
    // ignore: unused_label
    timeout:
    const Duration(seconds: 30);
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri) async {
    try {
      Response response =
          await get(uri); //here uri means only the end point needs to be passed
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
