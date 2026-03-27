import 'package:get/get.dart';
import '../data/repo/profile_repo.dart';
import '../ViewModel/profile_view_model.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRepo>(() => ProfileRepo());
    Get.lazyPut<ProfileViewModel>(
      () => ProfileViewModel(Get.find<ProfileRepo>()),
    );
  }
}
