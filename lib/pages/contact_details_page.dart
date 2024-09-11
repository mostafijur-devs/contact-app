import 'dart:io';

import 'package:contact_maneger/models/contact_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/contact_provider.dart';

class DetailsPage extends StatelessWidget {
  static const String routeNmae = '/details';

  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute
        .of(context)!
        .settings
        .arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) =>
            FutureBuilder<ConttactModels>(
              future: provider.getContactById(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final contact = snapshot.data;
                  return ListView(
                    padding: const EdgeInsets.all(15),
                    children: [

                      contact!.image == null ? Image.asset(
                        'assets/images/user.png',
                        height: 200,
                        width: 100,
                        fit: BoxFit.fill,):
                      Image.file(File(contact.image!,),
                        width:double.infinity,height: 250,fit: BoxFit.cover,),
                      ListTile(
                        title: Center(child: Text(contact.name, style: TextStyle(fontSize: 25),)),
                      ),
                      ListTile(
                        title: Text(contact.mobile,style: TextStyle(fontSize: 20),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: () {

                            }, icon: Icon(Icons.call)),
                            IconButton(onPressed: () {

                            }, icon: Icon(Icons.sms)),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Text(contact.email),
                        trailing: IconButton(onPressed: () {

                        }, icon:const Icon(Icons.email)),
                      ),
                      ListTile(
                        title: Text(contact.address),
                        trailing: IconButton(onPressed: () {

                        }, icon:const Icon(Icons.location_city)),
                      ),
                      ListTile(
                        title: Text(contact.dod!),
                        trailing: IconButton(onPressed: () {

                        }, icon:const Icon(Icons.date_range)),
                      ),



                    ],
                  );
                }
                if (snapshot.hasError) {
                  return const Text('Failed to fach data');
                }
                return Center(child: const CircularProgressIndicator());
              },
            ),
      ),
    );
  }
}
