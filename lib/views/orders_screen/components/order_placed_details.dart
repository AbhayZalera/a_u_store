import 'package:a_u_store/consts/consts.dart';

Widget orderPlaceDetails({title1, title2, d1, d2,required BuildContext context}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.screenWidth/2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title1".text.fontFamily(semibold).make(),
              "$d1".text.color(redColor).fontFamily(semibold).make(),

            ],
          ),
        ),
        SizedBox(
          width: context.screenWidth/2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontFamily(semibold).make(),
              "$d2".text.color(redColor).fontFamily(semibold).make(),

            ],
          ),
        )
      ],

    ),
  );

}