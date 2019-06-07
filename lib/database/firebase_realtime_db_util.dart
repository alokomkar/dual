
import 'package:dual_mode/database/constants.dart';
import 'package:dual_mode/database/database_crud_interface.dart';
import 'package:dual_mode/ui/language/code_language.dart';
import 'package:firebase_database/firebase_database.dart';


class FirebaseDBCrudForCodeLanguage extends DBCrudInterface<CodeLanguage>  {

  FirebaseDBCrudForCodeLanguage() : super(codeLanguageDB);

  @override
  Future<void> delete(CodeLanguage item) => databaseReference.child(item.id).remove();

  @override
  Future<void> insert(CodeLanguage item) {
    item.id = databaseReference.push().key;
    return databaseReference.child(item.id).set(item);
  }

  @override
  Future<DataSnapshot> read() => databaseReference.once();

  @override
  Future<void> update(CodeLanguage item) => databaseReference.child(item.id).set(item);

}