
import 'package:dual_mode/base/constants.dart';
import 'package:dual_mode/base/database_crud_interface.dart';
import 'package:dual_mode/ui/language/code_language.dart';
import 'package:firebase_database/firebase_database.dart';


class FirebaseDBCrudForCodeLanguage extends DBCrudInterface<CodeLanguage>  {

  FirebaseDBCrudForCodeLanguage() : super(codeLanguageDB);

  @override
  Future<void> delete(CodeLanguage item) => databaseReference.child(item.id).remove();

  @override
  Future<void> insert(CodeLanguage item) => databaseReference.child(item.id).set(item);

  @override
  Future<DataSnapshot> read() => databaseReference.orderByKey().once();

  @override
  Future<void> update(CodeLanguage item) => databaseReference.child(item.id).set(item);

}