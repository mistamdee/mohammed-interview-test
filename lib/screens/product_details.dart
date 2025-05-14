import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:interview_app/widgets/small_text.dart';

class ProductDetails extends StatelessWidget {
  var data;
   ProductDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leadingWidth: double.maxFinite,
        leading: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, size: 17,),
                SizedBox(width: 15.w,),
                SmallText(text: "Product details", textSize: 16,)
                
              ],
            ),
          ),
        ),
      ),

     body: SingleChildScrollView(
       child: Padding(
         padding:  EdgeInsets.all(20.r),
         child: Column(
          children: [
         
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: SmallText(text: "Product Title: ", fontWeight: FontWeight.w600,)),
                SizedBox(width: 20.w,),
                Expanded(child: SmallText(text: data['title']??""))
              ],
            ),

            SizedBox(height: 20.h,),

             Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: SmallText(text: "Product Subtitle: ", fontWeight: FontWeight.w600,)),
                SizedBox(width: 20.w,),
                Expanded(child: SmallText(text: data['body']??""))
              ],
            )
         
          ],
         ),
       ),
     ),
    );
  }
}