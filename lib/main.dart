import 'package:flutter/material.dart';
import './views/home_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
        Locale('pt', 'PT'),
        Locale('ja', 'JP'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales){
        // Check if the current device language is supported
        print(locale.languageCode + ' ' + locale.countryCode);
        for(var supportedLocale in supportedLocales){
          if(supportedLocale.languageCode == locale.languageCode && supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If not supported app will be english
        return supportedLocales.first;
      },
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: HomeView()),
    );
  }
}
