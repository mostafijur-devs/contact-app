import 'package:contact_maneger/models/contact_models.dart';
import 'package:contact_maneger/pages/contact_details_page.dart';
import 'package:flutter/material.dart';

class ContactItemView extends StatelessWidget {
  const ContactItemView({
    super.key,
    required this.contact,
    required this.onFevaritrButtonCHange
  });

  final ConttactModels contact;
  final Function(ConttactModels) onFevaritrButtonCHange;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, DetailsPage.routeNmae,
          arguments: contact.id),
      title: Text(contact.name),
      trailing: IconButton(
        onPressed: () {
          onFevaritrButtonCHange(contact);
        },
        icon: contact.favorite
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border),
      ),
    );
  }
}
