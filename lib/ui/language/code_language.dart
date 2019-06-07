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
        created = BigInt.zero/*snapshot.value["created"]*/,
        updated =  BigInt.zero/*snapshot.value["updated"]*/;

  static List<CodeLanguage> parseData(DataSnapshot dataSnapshot) {
    List<CodeLanguage> companyList =new List();

    // here you replace List map = snapshot.value with...
    Map<String, dynamic> mapOfMaps = Map.from( dataSnapshot.value );
    //actually dynamic here is another Map, String are the keys like -LXuQmyuF7E... or LXuSkMdJX...
    //of your picture example and dynamic other Map

    //in next lines we will interate in all values of your map
    //remeber that the values are maps too, values has one map for each company.
    //The values are Map<String, dynamic>
    //in this case String are keys like category, company_name, country, etc...
    //and dynamics data like string, int, float, etc

    //parsing and adding each Company object to list
    mapOfMaps.values.forEach( (value) {
      companyList.add(
        //here you'll not use fromSnapshot to parse data,
        //i thing you got why we're not using fromSnapshot
          CodeLanguage.fromJson( Map.from(value) )
      );
    });

    return companyList;

  }

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

  @override
  String toString() {
    return 'CodeLanguage{language: $language}';
  }

  CodeLanguage.fromJson(Map map) :
        id = map["id"],
        language = map["language"],
        description = map["description"],
        languageExtension = map["languageExtension"];


}