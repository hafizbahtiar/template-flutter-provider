import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template_flutter_provider/core/navigation/routes.dart';
import 'package:template_flutter_provider/data/objectbox/objectbox.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:template_flutter_provider/features/common/providers/preference_provider.dart';
import 'package:template_flutter_provider/features/common/providers/providers.dart';
import 'package:template_flutter_provider/features/home/home_screen.dart';

void main() async {
  // Ensure that plugin services are initialized so that plugins can be used
  // before the app starts.
  WidgetsFlutterBinding.ensureInitialized();
  final objectBox = await ObjectBox.create();
  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [Provider<ObjectBox>.value(value: objectBox), ...Providers.providers],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<PreferenceProvider>();

    return MaterialApp(
      title: 'Template Flutter Provider',
      locale: watch.currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: HomeScreen(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
