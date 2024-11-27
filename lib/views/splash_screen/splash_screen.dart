
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../auth_screen/login_screen.dart';
import '../home_screen/home.dart';
import '../widgets_common/applogo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Creating a Method to Change Screen
  changeScreen(){
    Future.delayed(const Duration(seconds: 3),(){
      //Get.to(()=> const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if(user == null && mounted){
          Get.to(()=> const LoginScreen());
        }
        else{
          Get.to(()=>const  Home());
        }
     });
    }  );
  }
  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: redColor,
      body: Column(
        children: [
          Align(alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg,width: 300)),
          applogoWidget(),
          10.heightBox,
          appname.text.fontFamily(bold).size(22).white.make(),
          5.heightBox,
          appversion.text.white.make(),
          const Spacer(),
          credits.text.white.fontFamily(semibold).make(),
          30.heightBox,
          //Our Splash Screen UI is Complected....

        ],
      ),

    );
  }
}
