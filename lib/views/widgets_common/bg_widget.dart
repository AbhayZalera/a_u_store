//
// Widget bgWidget({Widget? child}){
//   return Container(decoration: const BoxDecoration(
//       image: DecorationImage(
//           image: AssetImage(imgBackground),fit: BoxFit.fill)),
//   child: child,);
// }

import 'package:a_u_store/consts/consts.dart';

Widget bgWidget({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imgBackground),
        fit: BoxFit.fill,
      ),
    ),
    child: child,
  );
}