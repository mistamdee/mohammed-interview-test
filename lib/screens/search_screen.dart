import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:interview_app/Providers/product_provider.dart';
import 'package:interview_app/screens/product_details.dart';
import 'package:interview_app/widgets/small_text.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


late ProductProvider _productProvider;

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _productProvider = Provider.of<ProductProvider>(context, listen: false);
}

  @override
  void dispose() {
    _productProvider.disposeSearch();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     var productProvider = Provider.of<ProductProvider>(context, listen: true);
    return  Scaffold(
      resizeToAvoidBottomInset: false,

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
                SmallText(text: "Search for product", textSize: 16,)
                
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
        
            TextFormField(
              autofocus: true,
              decoration:InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade500,),
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.grey.shade500),
                contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.grey.shade300)
                ),

              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: Colors.grey.shade300)
                ),
              ),

              onChanged: (value) {
                Provider.of<ProductProvider>(context, listen: false).searchProduct(value);
              },
            ),

            SizedBox(height: 30.h,),

            Expanded(child:
             productProvider.searchList.isEmpty?
             Center(child: Padding(
               padding:  EdgeInsets.only(bottom: 100.h),
               child: SmallText(text: "Search \nProduct(0)"),
             )):
             ListView.builder(
              itemCount: productProvider.searchList.length,
              itemBuilder: (context, index) {
              var data = productProvider.searchList[index];
               return Padding(
                 padding:  EdgeInsets.only(bottom: 10.h),
                 child: ListTile(
                  dense: true,
                  title: SmallText(text: data['title']??"", fontWeight: FontWeight.w600,),
                  subtitle: SmallText(text: data['body']??""),
                   trailing: GestureDetector(
                    onTap: () => Get.to(()=>ProductDetails(data:data)),
                    child: Icon(Icons.visibility_off, size: 15,color: Colors.blue.shade800,)),
                 ),
               );
            },))
        
          ],
        ),
      ),
    );
  }
}