import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  static AuthProvider of(BuildContext context) {
    return Provider.of<AuthProvider>(context, listen: false);
  }

  Function? callback;

  void oAuth2Login(Function callback) {
    this.callback = callback;
  }
}
