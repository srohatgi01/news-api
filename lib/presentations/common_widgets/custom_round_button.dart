import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomRoundButton extends StatelessWidget {
  const CustomRoundButton({Key? key, required this.url, required this.text})
      : super(key: key);

  final String url;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _launchUrl,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.black),
        child: Text(text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
