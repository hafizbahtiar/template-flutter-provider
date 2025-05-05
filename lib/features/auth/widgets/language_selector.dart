import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String currentLocale;
  final Function(String?) onChanged;

  const LanguageSelector({super.key, required this.currentLocale, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            icon: const Padding(padding: EdgeInsets.only(left: 8.0), child: Icon(Icons.language)),
            value: currentLocale,
            onChanged: onChanged,
            items: const [
              DropdownMenuItem<String>(value: 'en', child: Text('English', overflow: TextOverflow.ellipsis)),
              DropdownMenuItem<String>(value: 'ms', child: Text('Malaysia', overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ],
    );
  }
}
