import 'package:flutter/material.dart';
import 'components/buttons.dart';
import 'package:get/get.dart';
import 'package:fitlife/routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  bool workoutReminder = true;
  bool pushNotifications = true;
  bool emailNotifications = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = darkMode ? Colors.black : Colors.white;
    final textColor = darkMode ? Colors.white : Colors.black87;
    final subtitleColor = darkMode
        ? Colors.grey.shade400
        : Colors.grey.shade600;
    final iconColor = darkMode ? Colors.white : Colors.grey.shade800;

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: iconColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- USER PROFILE ----------
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: darkMode
                      ? Colors.grey.shade800
                      : Colors.grey.shade300,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: darkMode
                        ? Colors.grey.shade200
                        : Colors.grey.shade800,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Yashfeen",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: textColor,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 18, color: subtitleColor),
              ],
            ),

            const SizedBox(height: 25),

            sectionTitle("Account Settings", textColor),

            settingsTile(
              "Edit Profile",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),
            settingsTile(
              "Change Email",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),
            settingsTile(
              "Change Password",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),

            const SizedBox(height: 20),
            sectionTitle("Preferences", textColor),

            settingsTile(
              "Units of Measurement",
              subtitle: "Metric (kg/cm)",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),
            settingsTile(
              "Language",
              subtitle: "English",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),

            switchTile(
              title: "Dark Mode",
              value: darkMode,
              onChanged: (v) => setState(() => darkMode = v),
              textColor: textColor,
            ),

            switchTile(
              title: "Workout Reminders",
              value: workoutReminder,
              onChanged: (v) => setState(() => workoutReminder = v),
              textColor: textColor,
            ),

            // ---------- EXTRA OPTIONAL SETTINGS ADDED ----------
            settingsTile(
              "Privacy Settings",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),
            settingsTile(
              "Connected Devices",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),
            settingsTile(
              "Subscription & Billing",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),
            settingsTile(
              "Data Backup & Sync",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),

            const SizedBox(height: 20),
            sectionTitle("Notifications", textColor),

            switchTile(
              title: "Push Notifications",
              value: pushNotifications,
              onChanged: (v) => setState(() => pushNotifications = v),
              textColor: textColor,
            ),

            switchTile(
              title: "Email Notifications",
              value: emailNotifications,
              onChanged: (v) => setState(() => emailNotifications = v),
              textColor: textColor,
            ),

            const SizedBox(height: 20),
            sectionTitle("Other", textColor),

            settingsTile(
              "Terms & Conditions",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),
            settingsTile(
              "Privacy Policy",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),
            settingsTile(
              "Help & Support",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),
            settingsTile(
              "About App",
              textColor: textColor,
              subtitleColor: subtitleColor,
            ),

            const SizedBox(height: 30),
            // use custom Buttons widget for logout
            Center(
              child: SizedBox(
                width: 220,
                child: Buttons(
                  customTextTwo: 'Logout',
                  onTap: () async {
                    // navigate to login and clear stack
                    Get.offAllNamed(Routes.login);
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ---------- UI COMPONENTS ----------

  Widget sectionTitle(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: textColor,
        ),
      ),
    );
  }

  Widget settingsTile(
    String title, {
    String? subtitle,
    required Color textColor,
    required Color subtitleColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: subtitleColor),
                  ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: subtitleColor),
        ],
      ),
    );
  }

  Widget switchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ),
          Switch(
            value: value,
            activeColor: Theme.of(context).primaryColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
