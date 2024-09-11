import 'dart:io';


import 'package:contact_maneger/db/db_helper.dart';
import 'package:contact_maneger/models/contact_models.dart';
import 'package:contact_maneger/provider/contact_provider.dart';
import 'package:contact_maneger/utils/constant.dart';
import 'package:contact_maneger/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewContactPage extends StatefulWidget {
  static const String routeNmae = '/new';

  const NewContactPage({super.key});

  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  final _nameControlar = TextEditingController();
  final _emailControlar = TextEditingController();
  final _addresControlar = TextEditingController();
  final _mobileControlar = TextEditingController();
  final _webControlar = TextEditingController();

  DateTime? _selectedDate;
  String? _group;
  String? _imagePath;
  Gender? gender;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
        actions: [IconButton(onPressed: _save, icon: const Icon(Icons.save))],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Card(
                      elevation: 10,
                      child: _imagePath == null ? const Icon(
                        Icons.person, size: 100,
                      ) : Image.file(File(_imagePath!), height: 100,
                        width: 100,
                        fit: BoxFit.fill,),
                    ),
                    Positioned(
                        right: -10,
                        top: -10,
                        child: IconButton(onPressed: () {
                          setState(() {
                            _imagePath = null;
                          });
                        }, icon: _imagePath == null? const Icon(Icons.cancel, size: 15,):const Icon(Icons.cancel, size: 15,color: Colors.white,) )
                    )

                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () {
                          _getImage(ImageSource.camera);
                        }, label: const Text('Capture')),
                    OutlinedButton.icon(
                        icon: const Icon(Icons.photo),
                        onPressed: () {
                          _getImage(ImageSource.gallery);
                        }, label: const Text('Gallary')),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: _nameControlar,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact name (required)',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a contact name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: _mobileControlar,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact mobile (required)',
                  prefixIcon: Icon(Icons.call),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a mobile number';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: _emailControlar,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact email (required)',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a email address';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: _addresControlar,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact address (required)',
                  prefixIcon: Icon(Icons.location_city),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a contact address';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: TextFormField(
                controller: _webControlar,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact web (optional)',
                  prefixIcon: Icon(Icons.web),
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: _selectDate,
                        child: const Text('Selected Date of Birth')),
                    Text(_selectedDate == null
                        ? 'No date choses'
                        : getDateFormat(_selectedDate!)!)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsetsDirectional.all(4),
                child: DropdownButtonFormField<String>(
                  hint: const Text('Selected group'),
                  isExpanded: true,
                  value: _group,
                  decoration: const InputDecoration(border: InputBorder.none),
                  items: groups
                      .map((group) =>
                      DropdownMenuItem<String>(
                          value: group, child: Text(group)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _group = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a group';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Seleced gender"),
            ),
            Row(
              children: [
                Radio<Gender>(
                  value: Gender.Male,
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text(Gender.Male.name),
                Radio<Gender>(
                  value: Gender.Female,
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text(Gender.Female.name),
                Radio<Gender>(
                  value: Gender.Other,
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text(Gender.Other.name),

              ],
            )
          ],
        ),
      ),
    );
  }

  void _save() {
    if (gender == null) {
      showMsg(context, 'Please input your gender');
      return;
    }
    if (_formKey.currentState!.validate()) {
      final contact = ConttactModels(
        name: _nameControlar.text,
        mobile: _mobileControlar.text,
        email: _emailControlar.text,
        address: _addresControlar.text,
        webSite: _webControlar.text.isEmpty ? null : _webControlar.text,
        group: _group!,
        gender: gender!.name,
        image: _imagePath,
        dod: getDateFormat(_selectedDate!)
      );
      // contact.read<ContactProvider>().addContact(contact).then()
      context.read<ContactProvider>().addContact(contact)
           .then((value) {
              showMsg(context, 'Saved');
              Navigator.pop(context);
           },)
      .catchError((error){
         showMsg(context, error.toString());
      });

    }
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      // initialDatePickerMode: DatePickerMode.year,
      helpText: 'sjdj',
      barrierColor: Colors.red.withOpacity(.5),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final xFile = await ImagePicker().pickImage(source: source);
    if (xFile != null) {
      setState(() {
        _imagePath = xFile.path;
      });
    }
  }
}
