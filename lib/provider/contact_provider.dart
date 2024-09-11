import 'package:contact_maneger/db/db_helper.dart';
import 'package:contact_maneger/models/contact_models.dart';
import 'package:flutter/foundation.dart';

class ContactProvider with ChangeNotifier{

List<ConttactModels> _contactList = [];
List<ConttactModels> get  contactList => _contactList;

final _db = DbHelper(); // DbHelper object create

Future<void> addContact (ConttactModels contact) async{
  final rowId = await _db.insertContact(contact);
  contact.id = rowId;
  _contactList.add(contact);
  notifyListeners();
}
Future<int> deleteContact(ConttactModels contact) async{
  return await _db.deleteContact(contact.id!);
}
Future<ConttactModels> getContactById(int id) async{
  return _db.getContactById(id);
}
Future<void> upDateFavarite (ConttactModels contact) async{
  final updatedFevariteValue = contact.favorite ? 0 : 1;
  final updateRowId = await _db.upDateFavorite(contact.id!, updatedFevariteValue);
  final position = _contactList.indexOf(contact);
  _contactList[position].favorite =!_contactList[position].favorite;
  notifyListeners();
}

Future<void> getAllContact () async{
  _contactList = await _db.getContactList();
  notifyListeners();
}

Future<void> getAllFevariteContact () async{
  _contactList = await _db.getAllFevariteContact();
  notifyListeners();
}

}