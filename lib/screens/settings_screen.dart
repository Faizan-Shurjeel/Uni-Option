import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart'; // Import ThemeProvider

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Theme'),
            subtitle: Text(
                'Current: ${themeProvider.themeMode.name.toUpperCase()}'), // Display current theme
            trailing: DropdownButton<ThemeMode>(
              value: themeProvider.themeMode,
              icon: const Icon(Icons.brightness_4_outlined),
              underline: const SizedBox.shrink(), // Hide default underline
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark'),
                ),
              ],
              onChanged: (ThemeMode? newMode) {
                if (newMode != null) {
                  // Use listen: false as we are calling a method, not rebuilding
                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(newMode);
                }
              },
            ),
            // Remove onTap as Dropdown handles interaction
          ),
          const Divider(),
          ListTile(
            title: const Text('About'),
            subtitle: const Text('App information'),
            trailing: const Icon(Icons.info_outline),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'UNI-OPTION',
                applicationVersion: '1.0.0', // TODO: Get version dynamically
                applicationLegalese: '© 2025 UNI-OPTION Devs',
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child:
                        Text('Helping Pakistani students find their future.'),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
