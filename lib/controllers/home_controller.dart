
import 'package:a_u_store/consts/consts.dart';
import 'package:get/get.dart';


class HomeController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;
  
  var username = '';

  getUsername() async {
    var n = await fireStore.collection(usersCollection).where('id',isEqualTo: currentUser!.uid).get().then((value) {
      if(value.docs.isNotEmpty){
        return value.docs.single['name'];
      }
    });

    username = n;
  }
}


