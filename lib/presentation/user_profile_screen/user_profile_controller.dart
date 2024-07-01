import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_model.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController{


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   // getProfile();
  }

  GetUserByIdModel getUserByIdModel = GetUserByIdModel();

  RxBool isLoading =true.obs;

  getUserById({required String userId}) async {
    // isLoading.value =true;
    getUserByIdModel =await ApiRepository.getUserById(userId: userId);
    isLoading.value =false;
  }

  getProfile() async {
    isLoading.value =true;
    getUserByIdModel =await ApiRepository.myProfile();
    isLoading.value =false;
  }


}