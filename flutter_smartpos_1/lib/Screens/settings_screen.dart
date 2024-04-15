import 'package:flutter/material.dart';
import 'package:flutter_smartpos_1/models/themenotifier.dart';
import 'package:flutter_smartpos_1/Widgets/main_drawer.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../models/profileprovider.dart';
import 'EditImageUrlScreen.dart';

class settingsScreen extends StatefulWidget {
  static const routeName = '/Settings';

  @override
  State<settingsScreen> createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {
  late ProfileProvider _profileProvider;
  TextEditingController _imageUrlController = TextEditingController();
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _profileProvider = context.read<ProfileProvider>();
    // Load the initial image URL from your user data
    _imageUrl =
        'https://example.com/default-image.jpg'; // Replace with your logic
    _imageUrlController.text = _imageUrl ?? '';
  }

  Future<void> _updateImageUrl(BuildContext context) async {
    final newImageUrl = await Navigator.of(context).pushNamed(
      EditImageUrlScreen.routeName,
      arguments: _imageUrl,
    );

    if (newImageUrl != null) {
      setState(() {
        _imageUrl = newImageUrl.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return Scaffold(
            drawer: MainDrawer(),
            appBar: AppBar(
              backgroundColor: themeNotifier.currentTheme.primaryColor,
              title: const Text('Settings'),
            ),
            body: SafeArea(
              child: SettingsList(sections: [
                SettingsSection(title: Text('Style'), tiles: <SettingsTile>[
                  SettingsTile(
                      title: Text('Theme'),
                      leading: Icon(Icons.format_paint),
                      trailing: DropdownButton<String>(
                        value: themeNotifier.currentTheme.primaryColor ==
                                Colors.green
                            ? 'Green'
                            : themeNotifier.currentTheme.primaryColor ==
                                    Colors.pink
                                ? 'Pink'
                                : 'Default', // Set initial value
                        onChanged: (String? newValue) {
                          if (newValue == 'Default') {
                            Provider.of<ThemeNotifier>(context, listen: false)
                                .setThemeColor(Colors.lightBlue);
                          }
                          if (newValue == 'Green') {
                            Provider.of<ThemeNotifier>(context, listen: false)
                                .setThemeColor(Colors.green);
                          } else if (newValue == 'Pink') {
                            Provider.of<ThemeNotifier>(context, listen: false)
                                .setThemeColor(Colors.pink);
                          }

                          // Handle dropdown value change
                        },
                        items: <String, String>{
                          'Default': 'Default',
                          'Green': 'Green',
                          'Pink': 'Pink'
                        }
                            .entries
                            .map<DropdownMenuItem<String>>(
                              (MapEntry<String, String> entry) =>
                                  DropdownMenuItem<String>(
                                value: entry.key,
                                child: Text(entry.value),
                              ),
                            )
                            .toList(),
                      ))
                ])
              ]),
            ));
      },
    );
  }
}
