import 'package:a_u_store/consts/consts.dart';

Widget ourButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
        ),
        backgroundColor: color,
        padding: const EdgeInsets.all(12),
      ),
      onPressed: onPress,
      child: title?.text.color(textColor).fontFamily(bold).make());
}
