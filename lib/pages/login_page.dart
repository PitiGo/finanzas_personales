import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../login_state.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(color: Colors.white),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Personal Finances app",
                  style: Theme.of(context).textTheme.display1,
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Image.asset('assets/undraw_segment_analysis_bdn4.png'),
                ),
                Text(
                  "Your personal finance app",
                  style: Theme.of(context).textTheme.caption,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 250.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Consumer<LoginState>(
                      builder: (context, LoginState value, Widget child) {
                        if (value.isLoading()) {
                          return CircularProgressIndicator();
                        } else {
                          return child;
                        }
                      },
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Color(0xffffffff),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.google,
                              color: Color(0xffCE107C),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Provider.of<LoginState>(context).login();
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                    width: 250.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Color(0xffffffff),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.facebookF,
                              color: Color(0xff4754de),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Sign in with Facebook',
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 18.0),
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    )),
                Container(
                    width: 250.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Color(0xffffffff),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.solidEnvelope,
                              color: Color(0xff4caf50),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Sign in with Email',
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 18.0),
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                    )),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.body1,
                      text: "To use this app you need to agree to our ",
                      children: [
                        TextSpan(
                          text: "Terms of Service",
                          // recognizer: _recognizer1,
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          // recognizer: _recognizer2,
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
