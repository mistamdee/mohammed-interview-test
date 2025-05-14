import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallText extends StatelessWidget {
  String text;
  double textSize;
  FontWeight? fontWeight;
  Color? textColor;
  String fontFamily;
  bool alignmentToMiddle;
  bool textoverFlow;
  int? maxline;
  

 
  SmallText({super.key, required this.text, this.textSize = 13, this.fontWeight, this.textColor, this.fontFamily="Aventa", this.alignmentToMiddle= false, this.textoverFlow= false, this.maxline});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignmentToMiddle? TextAlign.center:null,
      maxLines: maxline,
      style: TextStyle(
        
        overflow: textoverFlow? TextOverflow.ellipsis:null,
        fontSize: textSize.sp,
        fontWeight: fontWeight??null,
        color: textColor??Colors.black,
       // fontFamily: fontFamily,
        
      ),
    );
  }
}
