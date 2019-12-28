import "package:flutter/material.dart";
import 'package:flutter_01/routes/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_01/pages/splash.dart';
import 'package:flutter_01/routes/applicaton.dart';
import "package:provider/provider.dart";
import "package:flutter_01/provider/userProvider.dart";

void main() {
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  //Provider.debugCheckInvalidValueType = null;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(
        create: (context) => UserProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: SplashPage(), onGenerateRoute: Application.router.generator);
  }
}
