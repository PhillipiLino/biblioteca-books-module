import 'package:biblioteca_books_module/biblioteca_books_module.dart';
import 'package:clean_architecture_utils/localizations.dart';
import 'package:clean_architecture_utils/modular.dart';
import 'package:example/app_widget_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  AppWidgetState createState() => AppWidgetState();
}

class AppWidgetState extends State<AppWidget> with TickerProviderStateMixin {
  final key = GlobalKey<ScaffoldMessengerState>();
  final store = Modular.get<AppWidgetStore>();

  @override
  void initState() {
    super.initState();

    store.snackStream.listen((event) {
      key.currentState?.showSnackBar(
        SnackBar(
          content: Text(event.message),
          backgroundColor: event.color,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp.router(
      scaffoldMessengerKey: key,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      localizationsDelegates: const [
        BooksModuleLocalizationsDelegate(),
        ArchitectureLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 36, 38, 39),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
          accentColor: const Color.fromARGB(255, 96, 96, 96),
        ),
      ),
      supportedLocales: const [Locale('pt')],
      builder: (context, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            child ?? Container(),
            StreamBuilder<bool>(
              initialData: false,
              stream: store.loaderStream,
              builder: (_, AsyncSnapshot<bool> snapshot) {
                return (snapshot.data ?? false)
                    ? const CircularProgressIndicator()
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
