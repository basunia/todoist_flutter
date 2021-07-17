import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoist_app/model/Project.dart';
import 'package:todoist_app/model/Task.dart';
import 'package:todoist_app/util/http_client.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthProvider extends ChangeNotifier {

  Function? callback;
  final authorizationEndPoint =
      Uri.parse('https://todoist.com/oauth/authorize');
  final tokenEndPoint = Uri.parse('https://todoist.com/oauth/access_token');
  final identifier = dotenv.env['TODOIST_IDENTIFIER'];
  final secret = dotenv.env['TODOIST_SECRET'];
  final redirectUrl = Uri.parse('https://developer.todoist.com');
  oauth2.AuthorizationCodeGrant? grant;
  StreamSubscription? _sub;
  var accessToken;

  AuthProvider(){
    _read();
  }

  static AuthProvider of(BuildContext context) {
    return Provider.of<AuthProvider>(context, listen: false);
  }

_read() async{
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  if (token != null && token.isNotEmpty){
    accessToken = token;
    Http.getDio()?.options.headers['Authorization'] = 'Bearer $accessToken';
    notifyListeners();
  }
}
 

  void oAuth2Login(Function callback) {
    this.callback = callback;
    _createClient();
  }

  _createClient() async {
    grant = oauth2.AuthorizationCodeGrant(
        identifier!, authorizationEndPoint, tokenEndPoint,
        secret: secret);

    var authorizationUrl =
        grant?.getAuthorizationUrl(redirectUrl, scopes: ['data:read']);

    await redirect(authorizationUrl);
    listen(redirectUrl);
  }

  void retrieveAccessToken(Uri? responseUrl) async {
    oauth2.Client? client =
        await grant?.handleAuthorizationResponse(responseUrl!.queryParameters);
    this.callback!(client?.credentials);
  }

  Future<void> redirect(Uri? authorizationUrl) async {
    if (await canLaunch(authorizationUrl.toString())) {
      await launch(authorizationUrl.toString());
    }
  }

  Future<Uri?> listen(Uri redirectUrl) async {
    Uri? responseUrl;

    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri.toString().startsWith(redirectUrl.toString())) {
        responseUrl = uri;
        // retrieveAccessToken(responseUrl);
        oauth2HttpSignIn(responseUrl?.queryParameters['code']);
      }
    }, onError: (err) {
      toast('Failed to sign in using oauth');
    });

    return responseUrl;
  }

  void oauth2HttpSignIn(String? code) async {
    try {
      Http.getDio()?.options.baseUrl = 'https://todoist.com/'.toString();
      Response? response =
          await Http.getDio()?.post('oauth/access_token', data: {
        'client_id': identifier,
        'client_secret': secret,
        'code': code,
        'redirect_uri': redirectUrl.toString()
      });

      accessToken = response?.data['access_token'];
      this.callback!(response?.data['access_token']);
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
      }
    }
  }

  Future<List<Project>?> getAllProjects() async {
    try {
      Http.getDio()?.options.baseUrl = 'https://api.todoist.com/'.toString();
      // Http.getDio()?.options.headers['Authorization'] = 'Bearer $accessToken';
      Response? response = await Http.getDio()?.get('rest/v1/projects');

      return response?.data.map<Project>((e) => Project.fromMap(e)).toList();
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        return null;
      }
    }
  }

  Future<List<Task>?> getAllTasks(int projectId) async {
    try {
      Http.getDio()?.options.baseUrl = 'https://api.todoist.com/'.toString();
      // Http.getDio()?.options.headers['Authorization'] = 'Bearer $accessToken';
      Response? response = await Http.getDio()?.get('rest/v1/tasks', queryParameters: {
        "project_id": projectId
      });

      return response?.data.map<Project>((e) => Project.fromMap(e)).toList();
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response);
        return null;
      }
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
