import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ViewModel/profile_view_model.dart';

/// Reusable profile avatar widget that listens to ProfileViewModel.imageUrl
/// and shows an uploading overlay while the image is being uploaded.
class ProfileAvatar extends StatelessWidget {
  final double radius;
  final VoidCallback? onTap;

  const ProfileAvatar({Key? key, this.radius = 22.0, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel vm = Get.find<ProfileViewModel>();

    return GestureDetector(
      onTap: onTap,
      child: Obx(() {
        final url = vm.imageUrl.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: radius,
              backgroundImage: url != null
                  ? NetworkImage(url) as ImageProvider
                  : const AssetImage('assets/user.jpg'),
            ),
            if (vm.isUploading.value)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black26,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        );
      }),
    );
  }
}
