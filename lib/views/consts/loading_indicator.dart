
import 'package:a_u_store/consts/consts.dart';

Widget loadingIndicator(){
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}