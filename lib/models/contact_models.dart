// import 'dart:core';
const tableContact = 'tbl_contact';
const tableContactColId = 'id';
const tableContactColName = 'name';
const tableContactColMobile = 'mobile';
const tableContactColEmail = 'email';
const tableContactColAddress = 'address';
const tableContactColGroup = 'contact_group';
const tableContactColGender = 'gender';
const tableContactColWebsite = 'webSite';
const tableContactColImage = 'image';
const tableContactColDob = 'dob';
const tableContactColFavorite = 'favorite';


class ConttactModels {
  int? id;
  String name;

  String mobile;

  String email;
  String address;
  String group;
  String gender;
  String? webSite;
  String? image;

  String? dod;
  bool favorite;

  ConttactModels({
    this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.address,
    required this.group,
    required this.gender,
    this.webSite,
    this.image,
    this.dod,
    this.favorite = false,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tableContactColName: name,
      tableContactColEmail: email,
      tableContactColAddress: address,
      tableContactColImage: image,
      tableContactColMobile: mobile,
      tableContactColWebsite: webSite,
      tableContactColGroup: group,
      tableContactColGender: gender,
      tableContactColDob: dod,
      tableContactColFavorite: favorite ? 1 : 0,
    };
    return map;
  }

  factory ConttactModels.fromMap(Map<String, dynamic> map) {
    return ConttactModels(
      id: map[tableContactColId],
      name: map[tableContactColName],
      mobile: map[tableContactColMobile],
      email: map[tableContactColEmail],
      address: map[tableContactColAddress],
      group: map[tableContactColGroup],
      gender: map[tableContactColGender],
      webSite: map[tableContactColWebsite],
      dod: map[tableContactColDob],
      image: map[tableContactColImage],
      favorite: map[tableContactColFavorite] == 0 ?false:true,
    );
  }
  // @override
  // String toString() {
  //   // TODO: implement toString
  //   return super.toString();
  // }
}