import 'dart:io';

import 'package:contact_maneger/models/contact_models.dart';
import 'package:contact_maneger/pages/new_contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../provider/contact_provider.dart';
import '../utils/helper_function.dart';

class DetailsPage extends StatefulWidget {
  static const String routeNmae = '/details';
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late int id;

  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)!.settings.arguments as int;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Details Page'),
        actions: [
         TextButton(onPressed: () {
           Navigator.pushNamed(context, NewContactPage.routeNmae ,arguments: id)
           .then((_){
             setState(() {

             });
           });
         },
             child: const Text('Edit')),
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => FutureBuilder<ConttactModels>(
          future: provider.getContactById(id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final contact = snapshot.data;
              return ListView(

                padding: const EdgeInsets.all(15),
                children: [
                  contact!.image == null
                      ? ClipOval(
                        child: Image.asset(
                            'assets/images/user.png',
                            height: 200,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                      )
                      : Image.file(
                          File(
                            contact.image!,
                          ),
                          width: 150,
                          height: 250,
                          fit: BoxFit.fitHeight,
                        ),
                  ListTile(
                    title: Center(
                        child: Text(
                      contact.name,
                      style:const TextStyle(fontSize: 25),
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(onPressed: () {
                        _callNumber(contact.mobile);
                      }, icon: const Icon(Icons.call)),
                      IconButton(onPressed: () {
                        _massageNumber(contact.mobile);
                      }, icon: const Icon(Icons.sms)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Container(
                    color: Colors.grey.withOpacity(0.2),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 25,bottom: 15,top: 10),
                          child: Text('Contact info'),
                        ),
                        ListTile(
                          leading: IconButton(onPressed: () {
                            _callNumber(contact.mobile);
                          }, icon: Icon(Icons.call)),
                          title: Text(
                            contact.mobile,
                            style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Text('Mobile Defalts'),
                          trailing:  IconButton(onPressed: () {
                            _massageNumber(contact.mobile);
                          }, icon: const Icon(Icons.sms)),
                          // trailing:,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 10,),
                Container(
                  color: Colors.grey.withOpacity(0.1),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(contact.email),
                        subtitle: const Text('Email address' , style: TextStyle(fontSize: 10),),
                        trailing: IconButton(
                            onPressed: () {
                              _emailSet(contact.email);
                            }, icon: const Icon(Icons.email)),
                      ),
                      ListTile(
                        title: Text(contact.address),
                        trailing: IconButton(
                            onPressed: () {
                              _openMap(contact.address);
                            },
                            icon: const Icon(Icons.location_city)),
                      ),
                      ListTile(
                        title: Text(contact.dod!),
                        subtitle: const Text('Date of date'),
                        trailing: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.date_range)),
                      ),
                      ListTile(
                        title: Text(contact.group),
                        subtitle: const Text('groups',style: TextStyle(fontSize: 12),),
                        trailing: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.group)),
                      ),
                    ],
                  ),
                )
                ],
              );
            }
            if (snapshot.hasError) {
              return const Text('Failed to fach data');
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void _callNumber(String mobile) async {
    final url = 'tel:$mobile';
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }else{
      showMsg(context, 'Cannot perfrom this task');
    }

  }
  void _massageNumber(String mobile) async {
    final url = 'sms:$mobile';
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }else{
      showMsg(context, 'Cannot perfrom this task');
    }

  }

  void _emailSet(String email) async {
    final url = 'mailto:$email';
    if(await canLaunchUrlString(url)){
    await launchUrlString(url);
    }else{
    showMsg(context, 'Cannot perfrom this task');
    }
  }

  void _openMap(String address) async{
    final url;
    if(Platform.isAndroid){
      url = 'geo:0,0?q=$address';
    }else{
      url = 'http://maps.apple.com/?q=$address';
    }
    if(await canLaunchUrlString(url)){
      await launchUrlString(url);
    }else{
      showMsg(context, 'Cannot perfrom this task');
    }
  }
}
