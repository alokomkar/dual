import 'package:dual_mode/database/remote/constants.dart';
import 'package:dual_mode/database/remote/remote_db_base_interface.dart';
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
  Query read() => _getDatabaseQuery();

  Query _getDatabaseQuery() => databaseReference.orderByKey().limitToFirst(10);

  @override
  Future<void> update(CodeLanguage item) => databaseReference.child(item.id).set(item);

}