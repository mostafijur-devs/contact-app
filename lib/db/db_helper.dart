import 'package:contact_maneger/models/contact_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
class DbHelper{
  final createTableContact =''' create table $tableContact(
  $tableContactColId integer primary key autoincrement,
  $tableContactColName text,
  $tableContactColMobile text,
  $tableContactColEmail text,
  $tableContactColAddress text,
  $tableContactColWebsite text,
  $tableContactColDob text,
  $tableContactColGender text,
  $tableContactColGroup text,
  $tableContactColImage text,
  $tableContactColFavorite integer)''';

  Future<Database> _open() async{
    final rootPath = await getDatabasesPath();
    final dbPath = path.join(rootPath,'contact.db');
    return openDatabase(dbPath,version: 1, onCreate: (db, version){
    db.execute(createTableContact);
    },);
  }

  Future<int> insertContact ( ConttactModels contact) async{
    final db = await _open();
    return db.insert(tableContact,contact.toMap());
  }

  Future<List<ConttactModels>> getContactList ( ) async{
    final db = await _open();
    final mapList = await db.query(tableContact , orderBy: tableContactColName);
    return List.generate(mapList.length, (index) => ConttactModels.fromMap(mapList[index]));
  }

  Future<List<ConttactModels>> getAllFevariteContact ( ) async{
    final db = await _open();
    final mapList = await db.query(tableContact , orderBy: tableContactColName, where: '$tableContactColFavorite = ?', whereArgs: [1]);
    return List.generate(mapList.length, (index) => ConttactModels.fromMap(mapList[index]));
  }

  Future<ConttactModels> getContactById (int id ) async{
    final db = await _open();
    final mapList = await db.query(tableContact , where: '$tableContactColId = ?', whereArgs: [id]);
    return  ConttactModels.fromMap(mapList.first);
  }
  Future<int> upDateFavorite (int id, int value) async{
    final db = await _open();
    return db.update(tableContact, {tableContactColFavorite : value},where: '$tableContactColFavorite = ?', whereArgs: [id]);
  }


  Future<int> deleteContact (int id) async{
    final db = await _open();
     // delete from table_contact where id= general number
    return db.delete(tableContact, where: '$tableContactColId = ?', whereArgs: [id]);
    
  }
}