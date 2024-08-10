import 'package:flutter_auto_localizer/flutter_auto_localizer.dart';

void main() async {
  final localizationGenerator = AutoLocalizationGenerator(
    targetLanguages: ['es', 'fr', 'de'], // Add desired target languages here
  );

  await localizationGenerator.generate();
}
