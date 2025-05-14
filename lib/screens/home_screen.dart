import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:interview_app/Providers/product_provider.dart';
import 'package:interview_app/screens/product_details.dart';
import 'package:interview_app/screens/search_screen.dart';
import 'package:interview_app/widgets/small_text.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    Future.delayed(Duration.zero,(){
      Provider.of<ProductProvider>(context, listen: false).getProducts();
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leadingWidth: double.maxFinite,
        leading: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.black45,
              ),
              SmallText(text: "Welcome", fontWeight: FontWeight.w600,textSize: 16,),
              Icon(Icons.notifications_outlined)
            ],
          ),
        )
      ),
      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(20.r),
        child:  Column(
          children: [

            //Search
            GestureDetector(
              onTap: () {
                Get.to(()=> SearchScreen());
              },
              child: Container(
                height: 50.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10.r)
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 20.w,),
                    SmallText(text: "Search for product")
                  ],
                ),
              ),
            ),

            SizedBox(height: 30.h,),

           
           //Products
            Expanded(child:productProvider.loading_product?
            Center(child: CircularProgressIndicator()):
             ListView.builder(
              itemCount: productProvider.productList.length,
              itemBuilder: (context, index) {
               var data = productProvider.productList[index];
               return Padding(
                 padding:  EdgeInsets.only(bottom: 10.h),
                 child: ListTile(
                  dense: true,
                 // leading: Icon(Icons.card_giftcard_rounded),
                  title: SmallText(text: data['title']??"", fontWeight: FontWeight.w600,),
                  subtitle: SmallText(text: data['body']??""),
                    trailing: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                    onTap: () => Get.to(()=>ProductDetails(data:data)),
                    child: Icon(Icons.visibility_off, size: 15,color: Colors.blue.shade800,)),
                 ),
               );
             },))
        
          ],
        ),
      )),
    );
  }
}