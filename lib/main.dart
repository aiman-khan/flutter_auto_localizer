import 'dart:io';

import 'package:app_local/app_locale.dart';

void main() async {
  final localizationGenerator = AutoLocalizationGenerator(
    targetLanguages: ['es', 'fr', 'de'], // Add desired target languages here
  );

  await localizationGenerator.generate();
}
