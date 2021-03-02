import 'package:expanses/services/DBHelper.dart';
import 'package:expanses/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';
import 'providers/ExpensesProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.dbHelper.initDatabase();
  await translator.init(
    localeDefault: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
  );

  runApp(LocalizedApp(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExpensesProvider>(
      create: (context) {
        return ExpensesProvider();
      },
      child: GetMaterialApp(
          localizationsDelegates:
              translator.delegates, // Android + iOS Delegates
          locale: translator.locale, // Active locale
          supportedLocales: translator.locals(), //
          debugShowCheckedModeBanner: false,
          title: 'مصاريف',
          home: Builder(builder: (context) {
            translator.setNewLanguage(
              context,
              newLanguage: 'ar',
              remember: true,
              restart: true,
            );
            return SplashPage();
          })),
    );
  }
}
