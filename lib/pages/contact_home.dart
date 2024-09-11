import 'package:contact_maneger/custom_widgets/contact_item_view.dart';
import 'package:contact_maneger/main.dart';
import 'package:contact_maneger/pages/new_contact.dart';
import 'package:contact_maneger/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactHome extends StatefulWidget {
  static const String routeNmae = '/';

  const ContactHome({super.key});

  @override
  State<ContactHome> createState() => _ContactHomeState();
}

class _ContactHomeState extends State<ContactHome> {
  int _currentIndex = 0;


  @override
  void didChangeDependencies() {
    context.read<ContactProvider>().getAllContact();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemBuilder: (context, index) {
            final contact = provider.contactList[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              confirmDismiss: (direction) {
                return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('delete ${contact.name}?'),
                    content:
                        Text('Are you sure to delete contact ${contact.name},'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text('delete'),
                      ),
                    ],
                  ),
                );
              },
              onDismissed: (direction) {
                context.read<ContactProvider>().deleteContact(contact);
              },
              child: ContactItemView(
                contact: contact,
                onFevaritrButtonCHange: (contact) {
                  provider.upDateFavarite(contact);
                },
              ),
            );
          },
          itemCount: provider.contactList.length,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(
            context,
            NewContactPage.routeNmae,
          ),
          child: const Icon(Icons.add),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        child: Consumer<ContactProvider>(
          builder: (context, provider, child) =>BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;

              });
            } ,
            selectedItemColor: Colors.green,
            currentIndex: _currentIndex,
              items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'All',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'fevarite',
            ),
          ]),
        ),
        color: Colors.grey,
      ),
    );
  }
}
