import 'dart:io';

import 'package:app_local/flutter_auto_localizer.dart';

void main() async {
  final localizationGenerator = AutoLocalizationGenerator(
    targetLanguages: ['es', 'fr', 'de', 'nl'],
  );

  await localizationGenerator.generate();
}
