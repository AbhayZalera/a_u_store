// import 'package:a_u_store/views/orders_screen/components/order_placed_details.dart';
// import 'package:a_u_store/views/orders_screen/components/order_status.dart';
//
// import '../../consts/consts.dart';
// import 'package:intl/intl.dart' as intl;
// class OrdersDetails extends StatelessWidget {
//   final dynamic data;
//
//   const OrdersDetails({super.key, required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteColor,
//       appBar: AppBar(
//         title: "Order Details"
//             .text
//             .fontFamily(semibold)
//             .color(darkFontGrey)
//             .make(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           //scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               orderStatus(
//                   color: redColor,
//                   icon: Icons.done,
//                   title: "Placed",
//                   showDone: data['order_placed']),
//               orderStatus(
//                   color: Colors.blue,
//                   icon: Icons.thumb_up,
//                   title: "Confirmed",
//                   showDone: data['order_confirmed']),
//               orderStatus(
//                   color: Colors.green,
//                   icon: Icons.car_crash,
//                   title: "Delivery",
//                   showDone: data['order_on_delivery']),
//               orderStatus(
//                   color: Colors.purple,
//                   icon: Icons.done_all_rounded,
//                   title: "Delivered",
//                   showDone: data['order_delivered']),
//               const Divider(),
//               10.heightBox,
//               Column(
//                 children: [
//                   orderPlaceDetails(
//                       d1: data['order_code'],
//                       d2: data['shipping_method'],
//                       title1: "Order Code",
//                       title2: "Shipping Method",
//                     context: context
//                   ),
//                   orderPlaceDetails(
//                       d1: intl.DateFormat().add_yMd().format((data['order_date'].toDate())),
//                       d2: data['payment_method'],
//                       title1: "Order Code",
//                       title2: "Shipping Method",
//                       context: context),
//                   orderPlaceDetails(
//                       d1: "Unpaid",
//                       d2: "Order Placed",
//                       title1: "Payment Status",
//                       title2: "Delivery Status",
//                       context: context),
//
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width:context.screenWidth/2.5,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   "Shipping Address".text.fontFamily(semibold).make(),
//                                   "${data['order_by_name']}".text.make(),
//                                   "${data['order_by_email']}".text.make(),
//                                   "${data['order_by_address']}".text.make(),
//                                   "${data['order_by_city']}".text.make(),
//                                   "${data['order_by_state']}".text.make(),
//                                   "${data['order_by_phone']}".text.make(),
//                                   "${data['order_by_PinCode']}".text.make(),
//                                 ],
//                               ),
//                             )
//
//                           ],
//                         ),
//                         SizedBox(
//                           width: context.screenWidth/3,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               "Total Amount".text.fontFamily(semibold).make(),
//                               "${data['total_amount']}".numCurrency.text.color(redColor).fontFamily(bold).make(),
//                             ],
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   )
//                 ],
//               ).box.outerShadowMd.white.make(),
//               const Divider(),
//               10.heightBox,
//               "Ordered Product".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
//               10.heightBox,
//               ListView(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children:
//                   List.generate(data['orders'].length, (index) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         orderPlaceDetails(
//                           title1: data['orders'][index]['title'],
//                           title2: data['orders'][index]['tprice'],
//                           d1: "${data['orders'][index]['qty']} x ",
//                           d2: "Refundable",
//                             context: context
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                           child: Container(
//                             width: context.screenWidth/3,
//                               height: 20,
//                               //color: Color(data['orders'][index]['color']),
//                           ),
//                         ),
//                         const Divider(),
//                       ],
//                     );
//                   }).toList(),
//               ).box.outerShadowMd.white.margin(const EdgeInsets.only(bottom: 2.0)).make(),
//               20.heightBox,
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:a_u_store/views/orders_screen/components/order_placed_details.dart';
import 'package:a_u_store/views/orders_screen/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart' as intl;

import '../../consts/consts.dart';

class OrdersDetails extends StatelessWidget {
  final dynamic data;

  const OrdersDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _generatePDF(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                  color: redColor,
                  icon: Icons.done,
                  title: "Placed",
                  showDone: data['order_placed']),
              orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Confirmed",
                  showDone: data['order_confirmed']),
              orderStatus(
                  color: Colors.green,
                  icon: Icons.car_crash,
                  title: "Delivery",
                  showDone: data['order_on_delivery']),
              orderStatus(
                  color: Colors.purple,
                  icon: Icons.done_all_rounded,
                  title: "Delivered",
                  showDone: data['order_delivered']),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetails(
                    d1: data['order_code'],
                    d2: data['shipping_method'],
                    title1: "Order Code",
                    title2: "Shipping Method",
                    context: context,
                  ),
                  orderPlaceDetails(
                    d1: intl.DateFormat()
                        .add_yMd()
                        .format((data['order_date'].toDate())),
                    d2: data['payment_method'],
                    title1: "Order Date",
                    title2: "Payment Method",
                    context: context,
                  ),
                  orderPlaceDetails(
                    d1: "Unpaid",
                    d2: "Order Placed",
                    title1: "Payment Status",
                    title2: "Delivery Status",
                    context: context,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: context.screenWidth / 2.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Shipping Address"
                                      .text
                                      .fontFamily(semibold)
                                      .make(),
                                  "${data['order_by_name']}".text.make(),
                                  "${data['order_by_email']}".text.make(),
                                  "${data['order_by_address']}".text.make(),
                                  "${data['order_by_city']}".text.make(),
                                  "${data['order_by_state']}".text.make(),
                                  "${data['order_by_phone']}".text.make(),
                                  "${data['order_by_PinCode']}".text.make(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: context.screenWidth / 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data['total_amount']}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                              10.heightBox,
                              "Grand Total With GST"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                              "${data['total_amount'] + data['total_amount'] * 0.18}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowMd.white.make(),
              const Divider(),
              10.heightBox,
              "Ordered Product"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                        title1: data['orders'][index]['title'],
                        title2: data['orders'][index]['tprice'],
                        d1: "${data['orders'][index]['qty']} x ",
                        d2: "Refundable",
                        context: context,
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .white
                  .margin(const EdgeInsets.only(bottom: 2.0))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _generatePDF(BuildContext context) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Order Details",
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.Divider(),
              pw.Text("Order Code: ${data['order_code']}"),
              pw.Text("Shipping Method: ${data['shipping_method']}"),
              pw.Text(
                  "Order Date: ${intl.DateFormat().add_yMd().format((data['order_date'].toDate()))}"),
              pw.Text("Payment Method: ${data['payment_method']}"),
              pw.Text("Payment Status: Unpaid"),
              pw.Text("Delivery Status: Order Placed"),
              pw.Divider(),
              pw.Text("Shipping Address",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text("${data['order_by_name']}"),
              pw.Text("${data['order_by_email']}"),
              pw.Text("${data['order_by_address']}"),
              pw.Text("${data['order_by_city']}, ${data['order_by_state']}"),
              pw.Text("Phone: ${data['order_by_phone']}"),
              pw.Text("Pin Code: ${data['order_by_PinCode']}"),
              pw.Divider(),
              pw.Text("Total Amount: ${data['total_amount']}"),
              pw.Divider(),
              pw.Text(
                  "Grand Total With GST: Total Amount x 18% =  ${data['total_amount'] + data['total_amount'] * 0.18}"),
              pw.Divider(),
              pw.Text("Ordered Products",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.ListView.builder(
                itemCount: data['orders'].length,
                itemBuilder: (context, index) {
                  return pw.Column(
                    children: [
                      pw.Text(
                          "${data['orders'][index]['title']} - ${data['orders'][index]['qty']} x ${data['orders'][index]['tprice']}"),
                      pw.Divider(),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
