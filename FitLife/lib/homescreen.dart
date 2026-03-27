import 'package:flutter/material.dart';
import 'components/bottom_nav.dart';
import 'package:get/get.dart';
import 'ViewModel/profile_view_model.dart';
import 'data/repo/profile_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_screen.dart';
import 'components/profile_avatar.dart';

class HomeScreen extends StatelessWidget {
  final String? name;

  HomeScreen({super.key, this.name});

  @override
  Widget build(BuildContext context) {
    // Obtain or register ProfileRepo and ProfileViewModel at build time.
    final profileRepo = Get.isRegistered<ProfileRepo>()
        ? Get.find<ProfileRepo>()
        : Get.put(ProfileRepo());
    final ProfileViewModel _profileVM = Get.isRegistered<ProfileViewModel>()
        ? Get.find<ProfileViewModel>()
        : Get.put(ProfileViewModel(profileRepo));

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Make left side flexible so it can shrink when space is tight
                  Expanded(
                    child: Row(
                      children: [
                        // Use reusable ProfileAvatar which listens to the same ProfileViewModel
                        // so the UI will update automatically when imageUrl changes.
                        ProfileAvatar(
                          radius: 22,
                          onTap: () => _showPickOptions(context, _profileVM),
                        ),
                        const SizedBox(width: 10),
                        // Allow the text column to take remaining space and ellipsize
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Good Morning!",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                name != null && name!.isNotEmpty
                                    ? name!
                                    : 'Yashfeen',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right-side buttons should only take the space they need
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SettingsButton(),
                      const SizedBox(width: 12),
                      _PlusPopupButton(),
                      const SizedBox(width: 12),
                      _NotificationPopupButton(),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // DAILY SUMMARY
              const Text(
                "Daily Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D1E7C),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _summaryItem(
                      Icons.local_drink,
                      "Water intake",
                      "1.5L / 2L",
                    ),
                    _summaryItem(
                      Icons.bedtime,
                      "Sleep duration",
                      "7 hours / 8",
                    ),
                    _summaryItem(
                      Icons.directions_walk,
                      "Steps count",
                      "3,800 / 8,000",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // TODAY'S WORKOUT PLAN
              const Text(
                "Today's Workout Plan",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage("assets/workout.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.55),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      const Text(
                        "Full Body Strength",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Day 2 of 5 this week",
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 2.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2D1E7C),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Start Workout"),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // RECOMMENDATIONS
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Workout Recommendation",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // const Text("See All", style: TextStyle(color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 15),
              _recommendationCard("assets/cardio.jpg", "Cardio", "30 minutes"),
              const SizedBox(height: 12),
              _recommendationCard("assets/warmup.jpg", "Warm-up", "10 minutes"),
              const SizedBox(height: 12),
              _recommendationCard(
                "assets/running.jpg",
                "Running",
                "30 minutes",
              ),
              const SizedBox(height: 12),
              _recommendationCard("assets/planks.jpg", "Planks", "25 minutes"),
              const SizedBox(height: 12),
              _recommendationCard("assets/squats.jpg", "Squats", "15 minutes"),
            ],
          ),
        ),
      ),
    );
  }

  // SUMMARY ITEM
  Widget _summaryItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 12)),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // RECOMMENDATION ITEM
  Widget _recommendationCard(
    String img,
    String title,
    String time, {
    VoidCallback? onPlay,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(img, height: 60, width: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(time, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: onPlay,
                child: Container(
                  width: 33,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPickOptions(BuildContext context, ProfileViewModel profileVM) {
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
                profileVM.pickAndUpload(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.of(context).pop();
                profileVM.pickAndUpload(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Open profile screen'),
              onTap: () {
                Navigator.of(context).pop();
                Get.to(() => const ProfileScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PlusPopupButton extends StatefulWidget {
  @override
  State<_PlusPopupButton> createState() => _PlusPopupButtonState();
}

class _PlusPopupButtonState extends State<_PlusPopupButton> {
  final GlobalKey _key = GlobalKey();
  bool _isMenuOpen = false;

  Future<void> _showSmallMenu() async {
    final RenderBox button =
        _key.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final Offset topLeft = button.localToGlobal(Offset.zero, ancestor: overlay);

    final RelativeRect position = RelativeRect.fromLTRB(
      topLeft.dx,
      topLeft.dy + button.size.height + 8,
      topLeft.dx + button.size.width,
      topLeft.dy,
    );

    // mark menu open so UI (icon/color) can update
    setState(() => _isMenuOpen = true);

    await showMenu<String>(
      context: context,
      color: Colors.white,
      position: position,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        PopupMenuItem<String>(
          value: 'water',
          child: _menuRow(Icons.local_drink, 'Add Water Intake'),
        ),
        PopupMenuItem<String>(
          value: 'sleep',
          child: _menuRow(Icons.bedtime, 'Add Sleep Duration'),
        ),
        PopupMenuItem<String>(
          value: 'steps',
          child: _menuRow(Icons.directions_walk, 'Add Steps Count'),
        ),
      ],
    );

    // menu closed (user selected or dismissed) — reset icon
    if (mounted) setState(() => _isMenuOpen = false);
  }

  Widget _menuRow(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: _showSmallMenu,
      child: Icon(
        _isMenuOpen ? Icons.add_circle : Icons.add_circle_outline,
        size: 28,
        color: _isMenuOpen ? const Color(0xFF2D1E7C) : Colors.black,
      ),
    );
  }
}

class _NotificationPopupButton extends StatefulWidget {
  @override
  State<_NotificationPopupButton> createState() =>
      _NotificationPopupButtonState();
}

class _NotificationPopupButtonState extends State<_NotificationPopupButton> {
  final GlobalKey _key = GlobalKey();
  // track whether the notification menu is open so the icon color can update
  bool _isMenuOpen = false;

  Future<void> _showNotificationMenu() async {
    // mark menu open so UI (icon/color) can update
    if (mounted) setState(() => _isMenuOpen = true);
    final RenderBox button =
        _key.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final Offset topLeft = button.localToGlobal(Offset.zero, ancestor: overlay);

    final RelativeRect position = RelativeRect.fromLTRB(
      topLeft.dx,
      topLeft.dy + button.size.height + 8,
      topLeft.dx + button.size.width,
      topLeft.dy,
    );

    await showMenu<String>(
      context: context,
      color: Colors.white,
      position: position,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        PopupMenuItem<String>(
          value: 'reminders',
          child: _row(Icons.access_time, "Reminders"),
        ),
        PopupMenuItem<String>(
          value: 'alerts',
          child: _row(Icons.notifications_active, "System Alerts"),
        ),
        PopupMenuItem<String>(
          value: 'workouts',
          child: _row(Icons.fitness_center, "Upcoming Workouts"),
        ),
      ],
    );

    // menu closed (user selected or dismissed) — reset icon
    if (mounted) setState(() => _isMenuOpen = false);
  }

  Widget _row(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: _showNotificationMenu,
      child: Icon(
        Icons.notifications_none_outlined,
        size: 28,
        color: _isMenuOpen ? const Color(0xFF2D1E7C) : Colors.black,
      ),
    );
  }
}

// Simple settings button that toggles to the app's primary color on tap
class _SettingsButton extends StatefulWidget {
  @override
  State<_SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<_SettingsButton> {
  bool _active = false;

  void _toggle() {
    setState(() => _active = !_active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Icon(
        Icons.settings_outlined,
        size: 28,
        color: _active ? const Color(0xFF2D1E7C) : Colors.black,
      ),
    );
  }
}
