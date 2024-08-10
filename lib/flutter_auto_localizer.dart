library flutter_auto_localization;

import 'dart:convert';
import 'dart:io';
import 'package:translator/translator.dart';
import 'package:path/path.dart' as p;

class AutoLocalizationGenerator {
  final String defaultLanguageCode;
  final List<String> targetLanguages;

  AutoLocalizationGenerator({
    this.defaultLanguageCode = 'en',
    required this.targetLanguages,
  });

  Future<void> generate() async {
    final directory = Directory('lib/l10n');
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    final defaultFilePath =
        p.join(directory.path, 'app_$defaultLanguageCode.arb');
    final defaultFile = File(defaultFilePath);

    if (!defaultFile.existsSync()) {
      print(
          'No default language file found. Please create $defaultLanguageCode.arb with your English strings.');
      return;
    }

    final defaultTranslations =
        Map<String, String>.from(jsonDecode(defaultFile.readAsStringSync()));

    for (var lang in targetLanguages) {
      await _generateLanguageFile(lang, defaultTranslations);
    }
  }

  Future<void> _generateLanguageFile(
      String languageCode, Map<String, String> defaultTranslations) async {
    final translatedStrings =
        await _translateStrings(defaultTranslations, languageCode);

    final directory = Directory('lib/l10n');
    final filePath = p.join(directory.path, 'app_$languageCode.arb');
    final file = File(filePath);

    file.writeAsStringSync(jsonEncode(translatedStrings));
    print('Generated localization file for $languageCode at $filePath');
  }

  Future<Map<String, String>> _translateStrings(
      Map<String, String> strings, String targetLanguage) async {
    final Map<String, String> translatedStrings = {};

    final translator = GoogleTranslator();

    for (var entry in strings.entries) {
      final translatedText =
          await translator.translate(entry.value, to: targetLanguage);
      translatedStrings[entry.key] = translatedText.text;
    }

    return translatedStrings;
  }
}
