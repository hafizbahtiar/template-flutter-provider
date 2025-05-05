import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:template_flutter_provider/data/repositories/repositories.dart';
import 'package:template_flutter_provider/data/services/services.dart';

import 'preference_provider.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => PreferenceProvider(PreferencesRepository(PreferenceService()))),
  ];
}
