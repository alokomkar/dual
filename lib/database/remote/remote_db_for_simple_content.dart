import 'package:dual_mode/database/remote/constants.dart';
import 'package:dual_mode/database/remote/remote_db_base_interface.dart';
import 'package:dual_mode/ui/simple_content/simple_content.dart';
import 'package:firebase_database/firebase_database.dart';

class RemoteDBForSimpleContent extends DBCrudInterface<SimpleContent> {

  RemoteDBForSimpleContent( String selectedLanguage ) : super('$selectedLanguage/$simpleContentDB');

  @override
  Future<void> delete(SimpleContent item) => databaseReference.child(item.contentId).remove();

  @override
  Future<void> insert(SimpleContent item) {
    item.contentId = databaseReference.push().key;
    return databaseReference.child(item.contentId).set(item);
  }

  @override
  Query read() => databaseReference.orderByKey();

  @override
  Future<void> update(SimpleContent item) => databaseReference.child(item.contentId).set(item);

}