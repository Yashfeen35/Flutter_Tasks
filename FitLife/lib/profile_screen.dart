import 'package:flutter/material.dart';
import 'components/bottom_nav.dart';
import 'settings_screen.dart';
import 'package:get/get.dart';
import 'ViewModel/profile_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fitlife/routes.dart';
import 'components/profile_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel _vm = Get.find<ProfileViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () => Get.to(() => const SettingsScreen()),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      // add bottom navigation bar
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Profile Image + Name (reuse ProfileAvatar)
              ProfileAvatar(
                radius: 50,
                onTap: () => _showPickOptions(context, _vm),
              ),

              const SizedBox(height: 12),

              const Text(
                "Yashfeen",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              // Weight • Height • Age with vertical dividers
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Expanded(
                      child: _InfoBox(title: "Weight", value: "45 Kg"),
                    ),
                    _VerticalDivider(),
                    Expanded(
                      child: _InfoBox(title: "Height", value: "162 cm"),
                    ),
                    _VerticalDivider(),
                    Expanded(
                      child: _InfoBox(title: "Age", value: "25"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Edit Button using same purple style as the app
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  label: const Text(
                    "Edit",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3D2B86),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),

              const SizedBox(height: 25),

              // Account Sections
              const _SectionTitle("Account"),
              _ListTileItem(title: "My Plans", icon: Icons.event_note),
              _ListTileItem(title: "Fitness Level", icon: Icons.fitness_center),
              _ListTileItem(title: "Activity History", icon: Icons.history),

              const SizedBox(height: 15),

              const _SectionTitle("Other"),
              _ListTileItem(
                title: "Achievements / Milestones",
                icon: Icons.emoji_events,
              ),
              _ListTileItem(title: "Settings", icon: Icons.settings),
              _ListTileItem(
                title: "Logout",
                icon: Icons.logout,
                onTap: () {
                  // navigate to login screen and remove current route
                  Get.offAllNamed(Routes.login);
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _showPickOptions(BuildContext context, ProfileViewModel vm) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () {
                Navigator.of(context).pop();
                vm.pickAndUpload(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.of(context).pop();
                vm.pickAndUpload(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable small widgets:
class _InfoBox extends StatelessWidget {
  final String title;
  final String value;

  const _InfoBox({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _ListTileItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const _ListTileItem({required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: const Color(0xFF282165)),
          title: Text(title),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.black,
          ),
          onTap: onTap,
        ),
        Divider(height: 1),
      ],
    );
  }
}
