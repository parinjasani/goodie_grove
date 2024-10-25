import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),

      ),
    // Light Blue Background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy Policy",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "We respect your privacy and are committed to protecting the personal information you share with us. "
                    "This policy outlines how we collect, use, and protect your data.",
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
              SizedBox(height: 10),
              Text(
                "Data We Collect:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              BulletPoint(text: "Personal information such as name and email."),
              BulletPoint(text: "Usage data for improving user experience."),
              BulletPoint(text: "Information necessary for transactions."),
              SizedBox(height: 10),
              Text(
                "How We Use Your Data:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              BulletPoint(text: "To provide and maintain our services."),
              BulletPoint(text: "To notify users about changes or updates."),
              BulletPoint(text: "To improve user experience through analytics."),
              BulletPoint(text: "To protect against unauthorized access."),
              SizedBox(height: 10),
              Text(
                "Your Rights:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              BulletPoint(text: "You can request access to your data."),
              BulletPoint(text: "You can request deletion of your data."),
              BulletPoint(text: "You can opt-out of certain data usage."),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "By using our app, you agree to the terms outlined in this privacy policy.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 10, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}

