/*
The MIT License (MIT)

Copyright (c) 2019 Sami Benyoussef

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

This File Is Created By Sami Benyoussef

Developer: Sami Benyoussef
Email: contact@samibenyoussef.com
Github Repo: https://github.com/samiby/caloriya

*/

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './localization.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
      localizationsDelegates: [
        const LocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('fr', 'FR'),
        const Locale('de', 'DE'), // Added German Language Support
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          //
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
      // Add Internationalizations Support

      debugShowCheckedModeBanner: false,
      title: 'Caloriya',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
          primarySwatch: Colors.blue,
          //primaryColor: defaultTargetPlatform == TargetPlatform.android // Update Target Platform for Android Only
              //? Colors.white
              //: Colors.blue
      ),
      home: MyHomePage(title: 'Caloriya'),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  int calorieBase;
  int calorieAvecActivite;
  int radioSelectionnee;
  double poids;
  double age;
  bool genre = false;
  double taille = 170.0;
  Map mapActivite = {

    0: "Minimum", // Updated Text
    1: "Standard", // Updated Text
    2: "Maximum"
  };

  /* Begin App Exit Alert Dialog */
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(Localization.of(context).quitterApp), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
        content: new Text(Localization.of(context).quitterAppConfirmation), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(Localization.of(context).quitterAppConfirmationNON), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text(Localization.of(context).quitterAppConfirmationOUI), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
          ),
        ],
      ),
    ) ?? false;
  }
  /* End App Exit Alert Dialog */

  // BEGIN Implementing Tablet Support: Inspired from https://iirokrankka.com/2018/01/28/implementing-adaptive-master-detail-layouts
  Widget _buildMobileLayout() {

    return new WillPopScope(
      onWillPop: _onWillPop,

      /* return new GestureDetector( */
      child: new GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(new FocusNode())),

        child: new Scaffold(

          appBar: new AppBar(
            title: new Text(widget.title),
            backgroundColor: setColor(),
          ),

          body: new SingleChildScrollView(
            padding: EdgeInsets.all(15.0),

            child: new Column(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[

                padding(),
                //Localization.of(context).[string_resource_name]
                texteAvecStyle(Localization.of(context).remplissezTousLesChamps), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
                padding(),
                new Card(
                  elevation: 10.0,
                  child: new Column(

                    children: <Widget>[
                      padding(),

                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          texteAvecStyle(Localization.of(context).genteFemme, color: Colors.pink), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
                          new Switch(
                              value: genre,
                              inactiveTrackColor: Colors.pink,
                              activeTrackColor: Colors.blue,
                              onChanged: (bool b) {
                                setState(() {
                                  genre = b;
                                });
                              }
                          ),
                          texteAvecStyle(Localization.of(context).genteHomme, color: Colors.blue)
                        ],
                      ),
                      padding(),
                      new RaisedButton(
                          color: setColor(),
                          child: texteAvecStyle(
                              (age == null)? (Localization.of(context).appuyerPourEntrerVotreAge) : "Age : ${age.toInt()}", // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
                              color: Colors.white
                          ),
                          onPressed: (() => montrerPicker())
                      ),
                      padding(),
                      texteAvecStyle(
                          "Taille/Height: ${taille.toInt()} cm.", color: setColor()
                      ),
                      padding(),
                      new Slider(
                        value: taille,
                        activeColor: setColor(),
                        onChanged: (double d) {
                          setState(() {
                            taille = d;
                          });
                        },
                        max: 215.0,
                        min: 100.0,
                      ),
                      padding(),
                      //padding(), // Remove Padding to Fit The Input Text Field to Center

                      new TextField(
                        textAlign: TextAlign.center, // Center TextField: https://github.com/flutter/flutter/issues/9149

                        maxLength: 3,
                        maxLengthEnforced: true,

                        autofocus: false,
                        maxLines: 1, //https://stackoverflow.com/questions/53644897/how-do-i-remove-content-padding-from-textfield
                        autocorrect: false, // Prevent Keyboard to suggest numbers: https://medium.com/flutter-community/a-deep-dive-into-flutter-textfields-f0e676aaab7a

                        keyboardType: TextInputType.number,
                        onChanged: (String string) {
                          setState(() {
                            poids = double.tryParse(string);
                          });
                        },

                        decoration: new InputDecoration(

                          contentPadding: EdgeInsets.all(15.0), // https://api.flutter.dev//flutter/material/TextField/scrollPadding.html
                          border: InputBorder.none, // https://flutter.dev/docs/cookbook/forms/text-input

                          // Modified LabelText with with HintText to ba able to center the TextField: https://github.com/flutter/flutter/issues/9149
                          hintText: (Localization.of(context).entrezVotrePoidsEnKilos), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d

                        ),
                        obscureText: false, // Added to prevent stars text (example password field): https://medium.com/flutter-community/a-deep-dive-into-flutter-textfields-f0e676aaab7a

                      ),

                      padding(),
                      texteAvecStyle((Localization.of(context).quelleEstVotreActiviteSportive), color: setColor()), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
                      padding(),
                      rowRadio(),
                      padding()
                    ],
                  ),
                ),
                padding(),
                new RaisedButton(
                  color: setColor(),
                  child: texteAvecStyle((Localization.of(context).calculerCalories), color: Colors.white), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
                  onPressed: calculerNombreDeCalories,

                )

              ],

            ),

          ),


        ),

      ),

    );

  }
  // END Implementing Tablet Support: Inspired from https://iirokrankka.com/2018/01/28/implementing-adaptive-master-detail-layouts

  // BEGIN Implementing Tablet Support: Inspired from https://iirokrankka.com/2018/01/28/implementing-adaptive-master-detail-layouts
  Widget _buildTabletLayout() {

    // For tablets, return a layout that has item listing on the left
    // and item details on the right.
    return Row(

      children: <Widget>[

        Flexible(
          flex: 3,

          child: new WillPopScope(

            onWillPop: _onWillPop,

            /* return new GestureDetector( */
            child: new GestureDetector(
              onTap: (() => FocusScope.of(context).requestFocus(new FocusNode())),

              child: new Scaffold(

                appBar: new AppBar(
                  title: new Text(widget.title),
                  backgroundColor: setColor(),
                ),

                body: new SingleChildScrollView(
                  padding: EdgeInsets.all(15.0),

                  child: new Column(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: <Widget>[

                      padding(),
                      //Localization.of(context).[string_resource_name]
                      texteAvecStyle(Localization.of(context).remplissezTousLesChamps), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
                      padding(),
                      new Card(
                        elevation: 10.0,
                        child: new Column(

                          children: <Widget>[
                            padding(),

                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                texteAvecStyle(Localization.of(context).genteFemme, color: Colors.pink), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
                                new Switch(
                                    value: genre,
                                    inactiveTrackColor: Colors.pink,
                                    activeTrackColor: Colors.blue,
                                    onChanged: (bool b) {
                                      setState(() {
                                        genre = b;
                                      });
                                    }
                                ),
                                texteAvecStyle(Localization.of(context).genteHomme, color: Colors.blue)
                              ],
                            ),
                            padding(),
                            new RaisedButton(
                                color: setColor(),
                                child: texteAvecStyle(
                                    (age == null)? (Localization.of(context).appuyerPourEntrerVotreAge) : "Age : ${age.toInt()}", // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
                                    color: Colors.white
                                ),
                                onPressed: (() => montrerPicker())
                            ),
                            padding(),
                            texteAvecStyle(
                                "Taille/Height: ${taille.toInt()} cm.", color: setColor()
                            ),
                            padding(),
                            new Slider(
                              value: taille,
                              activeColor: setColor(),
                              onChanged: (double d) {
                                setState(() {
                                  taille = d;
                                });
                              },
                              max: 215.0,
                              min: 100.0,
                            ),
                            padding(),
                            //padding(), // Remove Padding to Fit The Input Text Field to Center

                            new TextField(
                              textAlign: TextAlign.center, // Center TextField: https://github.com/flutter/flutter/issues/9149

                              maxLength: 3,
                              maxLengthEnforced: true,

                              autofocus: false,
                              maxLines: 1, //https://stackoverflow.com/questions/53644897/how-do-i-remove-content-padding-from-textfield
                              autocorrect: false, // Prevent Keyboard to suggest numbers: https://medium.com/flutter-community/a-deep-dive-into-flutter-textfields-f0e676aaab7a

                              keyboardType: TextInputType.number,
                              onChanged: (String string) {
                                setState(() {
                                  poids = double.tryParse(string);
                                });
                              },

                              decoration: new InputDecoration(

                                contentPadding: EdgeInsets.all(15.0), // https://api.flutter.dev//flutter/material/TextField/scrollPadding.html
                                border: InputBorder.none, // https://flutter.dev/docs/cookbook/forms/text-input

                                // Modified LabelText with with HintText to ba able to center the TextField: https://github.com/flutter/flutter/issues/9149
                                hintText: (Localization.of(context).entrezVotrePoidsEnKilos), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d

                              ),
                              obscureText: false, // Added to prevent stars text (example password field): https://medium.com/flutter-community/a-deep-dive-into-flutter-textfields-f0e676aaab7a

                            ),

                            padding(),
                            texteAvecStyle((Localization.of(context).quelleEstVotreActiviteSportive), color: setColor()), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
                            padding(),
                            rowRadio(),
                            padding()
                          ],
                        ),
                      ),
                      padding(),
                      new RaisedButton(
                        color: setColor(),
                        child: texteAvecStyle((Localization.of(context).calculerCalories), color: Colors.white), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
                        onPressed: calculerNombreDeCalories,

                      )

                    ],

                  ),

                ),


              ),

            ),

          ),

        ),

      ],

    );

  }
  // END Implementing Tablet Support: Inspired from https://iirokrankka.com/2018/01/28/implementing-adaptive-master-detail-layouts

  // BEGIN Implementing Mobile/Tablet Layout BuildContext: Inspired from https://iirokrankka.com/2018/01/28/implementing-adaptive-master-detail-layouts
  @override
  Widget build(BuildContext context) {

    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var useMobileLayout = shortestSide < 600;

    if (useMobileLayout) {
      return _buildMobileLayout();
    }

    return _buildTabletLayout();

  }
  // END Implementing Mobile/Tablet Layout BuildContext: Inspired from https://iirokrankka.com/2018/01/28/implementing-adaptive-master-detail-layouts

  Padding padding() {
    return new Padding(padding: EdgeInsets.only(top: 20.0));
  }

  Future<Null> montrerPicker() async {
    DateTime choix = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now(),
        initialDatePickerMode: DatePickerMode.year
    );
    if (choix != null) {
      var difference = new DateTime.now().difference(choix);
      var jours = difference.inDays;
      var ans = (jours / 365);
      setState(() {
        age = ans;
      });
    }
  }

  Color setColor() {
    if (genre) {
      return Colors.blue;
    } else {
      return Colors.pink;
    }
  }

  Text texteAvecStyle(String data, {color: Colors.black, fontSize: 15.0}) {
    return new Text(
        data,
        textAlign: TextAlign.center,
        style: new TextStyle(
            color: color,
            fontSize: fontSize
        )
    );
  }

  Row rowRadio() {
    List<Widget> l = [];
    mapActivite.forEach((key, value) {
      Column colonne = new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Radio(
              activeColor: setColor(),
              value: key,
              groupValue: radioSelectionnee,
              onChanged: (Object i) {
                setState(() {
                  radioSelectionnee = i;

                });
              }),
          texteAvecStyle(value, color: setColor())
        ],
      );
      l.add(colonne);
    });
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: l,
    );
  }

  void calculerNombreDeCalories() {
    if (age != null && poids != null && radioSelectionnee != null) {
      //Calculer
      if (genre) {
        calorieBase = (66.4730 + (13.7516 * poids) + (5.0033 * taille) - (6.7550 * age)).toInt();
      } else {
        calorieBase = (655.0955 + (9.5634 * poids) + (1.8496 * taille) - (4.6756 * age)).toInt();
      }
      switch(radioSelectionnee) {
        case 0:
          calorieAvecActivite = (calorieBase * 1.2).toInt();
          break;
        case 1:
          calorieAvecActivite = (calorieBase * 1.5).toInt();
          break;
        case 2:
          calorieAvecActivite = (calorieBase * 1.8).toInt();
          break;
        default:
          calorieAvecActivite = calorieBase;
          break;
      }

      setState(() {
        dialogue();
      });

    } else {
      alerte();
    }
  }

  Future<Null> dialogue() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return SimpleDialog(
            title: texteAvecStyle((Localization.of(context).votreBesoinEnCalories), color: setColor()), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
            // contentPadding: EdgeInsets.all(15.0),
            children: <Widget>[
              padding(),
              texteAvecStyle("Base : $calorieBase"),
              padding(),
              texteAvecStyle("Base + Sport : $calorieAvecActivite"),
              new RaisedButton(onPressed: () {
                Navigator.pop(buildContext);
              },
                child: texteAvecStyle("OK", color: Colors.white),
                color: setColor(),
              )
            ],
          );
        }
    );
  }

  Future<Null> alerte() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return new AlertDialog(
            title: texteAvecStyle((Localization.of(context).erreurChampsObligatoires)), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
            content: texteAvecStyle((Localization.of(context).erreurTousLesChampsNeSontPasRemplis)), // Add Internationalizations Support: https://medium.com/flutterpub/improve-your-i18n-in-flutter-f3e960fca86d
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(buildContext);
                  },
                  child: texteAvecStyle("OK", color: Colors.red))
            ],
          );
        }
    );
  }

}