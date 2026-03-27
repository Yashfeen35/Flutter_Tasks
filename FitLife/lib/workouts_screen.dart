import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/bottom_nav.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  // simple sample dataset; replace or extend with your real data source
  final List<Map<String, String>> _allWorkouts = [
    {
      "title": "Walking",
      "subtitle": "Cardio · 15 min",
      "img": "assets/walking.jpg",
      "category": "Cardio",
    },
    {
      "title": "Running",
      "subtitle": "Cardio · 30 min",
      "img": "assets/running.jpg",
      "category": "Cardio",
    },
    {
      "title": "Cycling",
      "subtitle": "Cardio · 1 min",
      "img": "assets/cycling.jpeg",
      "category": "Cardio",
    },
    {
      "title": "Swimming",
      "subtitle": "Cardio · 1 min",
      "img": "assets/swimming.jpeg",
      "category": "Cardio",
    },
    {
      "title": "Hamstring Stretch",
      "subtitle": "Flexibility · 5 min",
      "img": "assets/warmup.jpg",
      "category": "Flexibility",
    },
    {
      "title": "Forward Fold",
      "subtitle": "Flexibility · 3 min",
      "img": "assets/planks.jpg",
      "category": "Flexibility",
    },
    {
      "title": "Neck Stretch",
      "subtitle": "Flexibility · 3 min",
      "img": "assets/planks.jpg",
      "category": "Flexibility",
    },
    {
      "title": "Squats",
      "subtitle": "Strength · 3x12",
      "img": "assets/squats.jpg",
      "category": "Strength",
    },
    {
      "title": "Lunges",
      "subtitle": "Strength · 3x10",
      "img": "assets/planks.jpg",
      "category": "Strength",
    },
    {
      "title": "Push-ups",
      "subtitle": "Strength · 3x15",
      "img": "assets/squats.jpg",
      "category": "Strength",
    },
    {
      "title": "Planks",
      "subtitle": "Strength · 3x15",
      "img": "assets/squats.jpg",
      "category": "Strength",
    },
    {
      "title": "Crunches",
      "subtitle": "Strength · 3x15",
      "img": "assets/squats.jpg",
      "category": "Strength",
    },
    {
      "title": "High knees",
      "subtitle": "HIIT · 8 rounds",
      "img": "assets/fitness2.jpg",
      "category": "HIIT",
    },
    {
      "title": "Russian twists",
      "subtitle": "HIIT · 8 rounds",
      "img": "assets/fitness2.jpg",
      "category": "HIIT",
    },
    {
      "title": "Box jumps",
      "subtitle": "HIIT · 8 rounds",
      "img": "assets/fitness2.jpg",
      "category": "HIIT",
    },
  ];

  String _selectedCategory = "All";

  // derive category list from workouts so any new item shows up automatically
  List<String> get _categories {
    // collect unique, non-null, trimmed categories from _allWorkouts
    final cats = _allWorkouts
        .map((w) => (w['category'] ?? '').trim())
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList();
    // keep the original order (optional): we'll sort alphabetically except keep 'All' first
    cats.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return ["All", ...cats];
  }

  List<Map<String, String>> get _filteredWorkouts {
    if (_selectedCategory.toLowerCase().trim() == "all") return _allWorkouts;
    final selected = _selectedCategory.toLowerCase().trim();
    return _allWorkouts
        .where((w) => (w['category'] ?? '').toLowerCase().trim() == selected)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // compute filtered list here (can't declare statements inside widget children list)
    final filtered = _filteredWorkouts;

    return Scaffold(
      backgroundColor: Colors.white,
      // show bottom nav and mark this as the Workouts tab
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      appBar: AppBar(
        // remove automatic back arrow (no pop navigation)
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Workout",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: false,
        actions: const [
          Icon(Icons.search, color: Colors.black, size: 26),
          SizedBox(width: 15),
          Icon(Icons.filter_list, color: Colors.black, size: 26),
          SizedBox(width: 15),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -----------------------------------------
            // OVERALL SUMMARY
            // -----------------------------------------
            const Text(
              "Overall Summary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            LayoutBuilder(
              builder: (context, constraints) {
                const int gap = 12;
                final int totalGaps = gap * 2;
                final int available = (constraints.maxWidth - totalGaps)
                    .floor();
                final int base = available ~/ 3; // integer division
                final int rem = available % 3; // leftover pixels
                final double w1 = (base + (rem > 0 ? 1 : 0)).toDouble();
                final double w2 = (base + (rem > 1 ? 1 : 0)).toDouble();
                final double w3 = (base).toDouble();
                return Row(
                  children: [
                    SizedBox(
                      width: w1,
                      child: _SummaryBox(title: "Workout", value: "184"),
                    ),
                    SizedBox(width: gap.toDouble()),
                    SizedBox(
                      width: w2,
                      child: _SummaryBox(
                        title: "Hours Trained",
                        value: "76 hrs",
                      ),
                    ),
                    SizedBox(width: gap.toDouble()),
                    SizedBox(
                      width: w3,
                      child: _SummaryBox(
                        title: "Calories Burned",
                        value: "35,840",
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 25),

            const Text(
              "Today's Workout Plan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Container(
              height: 210,
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
                    colors: [Color.fromRGBO(0, 0, 0, 0.5), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),

                    Row(
                      children: [
                        // make the three info items flexible so they fit smaller widths
                        Expanded(
                          child: _WorkoutInfoIcon(
                            Icons.fitness_center,
                            "Workout 3",
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _WorkoutInfoIcon(Icons.timer, "30 min"),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _WorkoutInfoIcon(
                            Icons.local_fire_department,
                            "350 kcal",
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2D1E7C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Continue Workout",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // -----------------------------------------
            // BEST WORKOUT SECTION
            // -----------------------------------------
            Row(
              children: const [
                Expanded(
                  child: Text(
                    "Best Workouts",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8),
                Text("See All", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 15),

            // Category Chips (tappable)
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 4, bottom: 4),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, idx) {
                  final label = _categories[idx];
                  final selected = _selectedCategory == label;
                  // pass the onTap into _ChipItem directly to avoid nested GestureDetectors
                  return _ChipItem(
                    label: label,
                    selected: selected,
                    onTap: () => setState(() => _selectedCategory = label),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Workout item cards (filtered). Show a friendly empty state if no workouts in the category.
            if (filtered.isEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36.0),
                child: Center(
                  child: Text(
                    'No workouts found for "$_selectedCategory"',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ),
            ] else
              ...List.generate(filtered.length, (i) {
                final w = filtered[i];
                return Column(
                  children: [
                    _WorkoutListTile(
                      img: w['img']!,
                      title: w['title']!,
                      subtitle: w['subtitle']!,
                      onPlay: () {
                        // pass the whole filtered list + index so the player can navigate prev/next
                        Get.to(
                          () => ExercisePlayerScreen(
                            workouts: filtered,
                            initialIndex: i,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                );
              }),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

//
// --- REUSABLE WIDGETS ---
//

class _SummaryBox extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryBox({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      // ensure the box fills the available width from its parent Expanded
      width: double.infinity,
      // give a consistent minimum height so all boxes visually match
      constraints: const BoxConstraints(minHeight: 72),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _WorkoutInfoIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _WorkoutInfoIcon(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.white),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ChipItem extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const _ChipItem({required this.label, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF2D1E7C) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}

class _WorkoutListTile extends StatelessWidget {
  final String img;
  final String title;
  final String subtitle;
  final VoidCallback? onPlay;

  const _WorkoutListTile({
    required this.img,
    required this.title,
    required this.subtitle,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
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
            child: Image.asset(img, height: 50, width: 45, fit: BoxFit.cover),
          ),
          const SizedBox(width: 14),

          // make the text take remaining space so the play button stays at the end
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // small circular play button
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
    );
  }
}

class ExercisePlayerScreen extends StatefulWidget {
  final List<Map<String, String>> workouts;
  final int initialIndex;

  const ExercisePlayerScreen({
    Key? key,
    List<Map<String, String>>? workouts,
    int? initialIndex,
  }) : workouts = workouts ?? const <Map<String, String>>[],
       initialIndex = initialIndex ?? 0,
       super(key: key);

  @override
  State<ExercisePlayerScreen> createState() => _ExercisePlayerScreenState();
}

class _ExercisePlayerScreenState extends State<ExercisePlayerScreen> {
  bool _isPlaying = false;
  Timer? _timer;
  late int _currentIndex;
  late int _remainingSeconds;
  late int _initialSeconds;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _initialSeconds = _parseDuration(
      widget.workouts[_currentIndex]['subtitle'] ?? '',
    );
    _remainingSeconds = _initialSeconds;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int _parseDuration(String subtitle) {
    // extract the part after '·' if present
    final part = subtitle.contains('·')
        ? subtitle.split('·').last.trim()
        : subtitle.trim();
    // minutes like '15 min'
    final minMatch = RegExp(r"(\d+)\s*min").firstMatch(part);
    if (minMatch != null) {
      final mins = int.tryParse(minMatch.group(1)!) ?? 0;
      if (mins > 0) return mins * 60;
    }
    // seconds like '30 sec' or '30s'
    final secMatch = RegExp(r"(\d+)\s*(sec|s)").firstMatch(part);
    if (secMatch != null) {
      final secs = int.tryParse(secMatch.group(1)!) ?? 0;
      if (secs > 0) return secs;
    }
    // fallback: look for any number and treat as minutes if small or seconds
    final numMatch = RegExp(r"(\d+)").firstMatch(part);
    if (numMatch != null) {
      final n = int.tryParse(numMatch.group(1)!) ?? 0;
      if (part.contains('hr') || part.contains('hrs')) return n * 3600;
      // if number <= 60 assume minutes, else seconds
      if (n <= 60) return n * 60;
      return n;
    }
    // default 30 seconds
    return 30;
  }

  void _startTimer() {
    _timer?.cancel();
    if (_remainingSeconds <= 0) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds -= 1;
        } else {
          _isPlaying = false;
          t.cancel();
        }
      });
    });
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        if (_remainingSeconds <= 0) _remainingSeconds = _initialSeconds;
        _startTimer();
      } else {
        _timer?.cancel();
      }
    });
  }

  void _changeDurationBy(int deltaSeconds) {
    setState(() {
      _remainingSeconds = ((_remainingSeconds + deltaSeconds).clamp(5, 3600));
      // if user changes while stopped, also update initial so reset uses new value
      if (!_isPlaying) _initialSeconds = _remainingSeconds;
    });
  }

  void _onSliderChanged(double val) {
    setState(() {
      _remainingSeconds = val.round();
      if (!_isPlaying) _initialSeconds = _remainingSeconds;
    });
  }

  void _goToIndex(int newIndex) {
    final len = widget.workouts.length;
    if (len == 0) return;
    setState(() {
      _currentIndex = (newIndex % len + len) % len; // wrap
      _timer?.cancel();
      _isPlaying = false;
      _initialSeconds = _parseDuration(
        widget.workouts[_currentIndex]['subtitle'] ?? '',
      );
      _remainingSeconds = _initialSeconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    final workout = widget.workouts[_currentIndex];
    final category = workout['category'] ?? '';
    final title = workout['title'] ?? '';
    final subtitle = workout['subtitle'] ?? '';
    final img = workout['img'] ?? 'assets/workout.jpg';

    String _format(int seconds) {
      final m = seconds ~/ 60;
      final s = seconds % 60;
      return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- TOP BAR ----------
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back, size: 26),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    category.isNotEmpty ? category : 'Workout',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ---------- WORKOUT IMAGE IN CIRCLE ----------
              Center(
                child: Container(
                  height: 260,
                  width: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: Center(
                    child: ClipOval(
                      child: Image.asset(
                        img,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              'assets/workout.jpg',
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ---------- WORKOUT NAME + TIMER DISPLAY ----------
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              // big timer text
              Center(
                child: Text(
                  _format(_remainingSeconds),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ---------- DURATION CONTROLS: - button, slider, + button ----------
              Row(
                children: [
                  IconButton(
                    onPressed: () => _changeDurationBy(-5),
                    icon: const Icon(Icons.remove_circle_outline),
                    color: const Color(0xFF6E49D9),
                  ),
                  Expanded(
                    child: Slider(
                      min: 5,
                      max: 3600,
                      divisions: 71,
                      value: _remainingSeconds.toDouble().clamp(5, 3600),
                      onChanged: (v) => _onSliderChanged(v),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _changeDurationBy(5),
                    icon: const Icon(Icons.add_circle_outline),
                    color: const Color(0xFF6E49D9),
                  ),
                ],
              ),

              const Spacer(),

              // ---------- PLAY/PAUSE and PREV/NEXT ----------
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: _togglePlay,
                    child: Container(
                      height: 64,
                      decoration: BoxDecoration(
                        color: _isPlaying
                            ? const Color(0xFF3D2B86)
                            : Colors.white,
                        // borderRadius: BorderRadius.circular(50),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 36,
                          color: _isPlaying ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => _goToIndex(_currentIndex - 1),
                        child: Column(
                          children: [
                            const Icon(Icons.skip_previous, size: 34),
                            const SizedBox(height: 4),
                            Text(
                              'Previous',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: () => _goToIndex(_currentIndex + 1),
                        child: Column(
                          children: [
                            const Icon(Icons.skip_next, size: 34),
                            const SizedBox(height: 4),
                            Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
