import 'package:dual_mode/database/remote/constants.dart';
import 'package:dual_mode/database/remote/remote_db_base_interface.dart';
import 'package:dual_mode/ui/chapters/chapters.dart';
import 'package:firebase_database/firebase_database.dart';

class RemoteDBForChapters extends DBCrudInterface<Chapter> {

  RemoteDBForChapters( String selectedLanguage ) : super('$selectedLanguage/$masterContentDB');

  @override
  Future<void> delete(Chapter item) => databaseReference.child(item.chapterId).remove();

  @override
  Future<void> insert(Chapter item) {
    item.chapterId = databaseReference.push().key;
    return databaseReference.child(item.chapterId).set(item);
  }

  @override
  Future<void> update(Chapter item) => databaseReference.child(item.chapterId).set(item);

  @override
  Query read() => databaseReference.orderByKey();

}