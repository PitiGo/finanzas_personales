// import 'package:finanzas_personales/login_state.dart';
import 'package:finanzas_personales/pages/details_page.dart';
import 'package:finanzas_personales/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'package:finanzas_personales/pages/home_page.dart';
import 'package:provider/provider.dart';

import 'login_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color colorBase=Color(0xff38D39F);
    return ChangeNotifierProvider<LoginState>(
      builder: (BuildContext context) => LoginState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: colorBase,
        ),
        onGenerateRoute: (settings) {
          DetailsParams params = settings.arguments;
          if (settings.name == '/details') {
             
            //  Rect buttonRect = settings.arguments;
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return DetailsPage(
                  params: params,
                );
              }
            );
          }else return MaterialPageRoute();
        },
        routes: {
          
          '/': (BuildContext context) {
            var state = Provider.of<LoginState>(context);
            if (state.isLogged()) {
              return MyHomePage();
            } else {
              return LoginPage();
            }
          },
        },
      ),
    );
  }
}
