import 'package:firebase_database/firebase_database.dart';

class CodeLanguage {

  String id;
  String language;
  String description;
  String languageExtension;
  BigInt created;
  BigInt updated;

  CodeLanguage(
      this.id,
      this.language,
      this.description,
      this.languageExtension,
      this.created,
      this.updated);

  CodeLanguage.fromDataSnapshot(DataSnapshot snapshot) :
        id = snapshot.key,
        language = snapshot.value["language"],
        description = snapshot.value["description"],
        languageExtension = snapshot.value["languageExtension"],
        created = snapshot.value["created"],
        updated = snapshot.value["updated"];

  toJson() {
    return {
      "id": id,
      "language": language,
      "description": description,
      "languageExtension": languageExtension,
      "created": created,
      "updated": updated,
    };
  }

}