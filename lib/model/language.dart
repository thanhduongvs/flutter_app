import 'package:iot_kminh/resources/strings.dart';

class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;

  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇻🇳", Strings.vietnamese, "vi"),
      Language(2, "🇺🇸", Strings.english, "en"),
    ];
  }
}
