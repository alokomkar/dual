import 'package:dual_mode/database/constants.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class DBCrudInterface<T> {

  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  DBCrudInterface( String dbUrl ) {
    databaseReference = database.reference().child( pcDBVersion + "/" + dbUrl );
  }

  Future<void> insert( T item );
  Future<void> delete( T item );
  Future<void> update( T item );
  DatabaseReference read();
}