import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoWidget extends StatelessWidget {
  final String phone;
  final String email;
  final String website;

  const ContactInfoWidget({
    super.key,
    required this.phone,
    required this.email,
    required this.website,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (phone.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text(phone),
                onTap: () => _launchUrl('tel:$phone'),
                contentPadding: EdgeInsets.zero,
              ),
            if (email.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.email),
                title: Text(email),
                onTap: () => _launchUrl('mailto:$email'),
                contentPadding: EdgeInsets.zero,
              ),
            if (website.isNotEmpty)
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(website),
                onTap: () => _launchUrl(website),
                contentPadding: EdgeInsets.zero,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $urlString');
    }
  }
}