import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reunion_card_web/app/core/constants/assets_constants.dart';
import 'package:reunion_card_web/app/core/widgets/svg_image_viewer.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // SvgImageViewer(
          //   imageName: backgroundSvg,
          //   height: Get.height,
          //   width: Get.width,
          // ),
          Opacity(
            opacity: .2,
            child: Image.asset(
              edwardClg,
              height: Get.height,
              width: Get.width,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 36.h,
            left: 26.w,
            right: 26.w,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        reunion,
                        width: 0.15.sw,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 4.5.w,
                      ),
                      Column(
                        children: [
                          Text(
                            "ব্যবস্থাপনা বিভাগ (পুনর্মিলনী এবং সুবর্ন জয়ন্তী)",
                            style: GoogleFonts.anekBangla(
                              fontSize: 8.5.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff263A9B),
                                letterSpacing: 4.28
                            ),
                          ),
                          Text(
                            "এডওয়ার্ড কলেজ, পাবনা, সকল ব্যাচ - ২০২৪",
                            style: GoogleFonts.anekBangla(
                              fontSize: 6.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff263A9B),
                              height: .8,
                              letterSpacing: 3.3
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffFB588F),
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 4.h,
                            ),
                            child: Text(
                              "রেজিঃ নং- ৫০০১",
                              style: GoogleFonts.anekBangla(
                                fontSize: 6.sp,
                                fontWeight: FontWeight.w800,
                                color: Color(0xff263A9B),
                                letterSpacing: 2.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "তারিখঃ ২৭ ডিসেম্বর ২০২৪। শুক্রবার  স্থানঃ ব্যবস্থাপনা ভবন",
                            style: GoogleFonts.anekBangla(
                              fontSize: 5.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff0A7E9B),
                              letterSpacing: 3,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 72.h,
                  ),
                  IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 9.w),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            infoForm,
                            height: 0.21.sh,
                            width: 0.34.sw,
                            fit: BoxFit.fill,
                          ),
                          VerticalDivider(width: 12.w,),
                          SizedBox(
                            width: 2.w,
                          ),
                          Image.asset(
                            registrationFee,
                            height: 0.2.sh,
                            width: 0.17.sw,
                            fit: BoxFit.fill,
                          ),
                          VerticalDivider(width: 13.w,),
                          Image.asset(
                            transactionInfo,
                            height: 0.2.sh,
                            width: 0.18.sw,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 65.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          tshirtCoupon,
                          height: 0.2.sh,
                          width: 0.2.sw,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Image.asset(
                          raffleCoupon,
                          height: 0.2.sh,
                          width: 0.28.sw,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Image.asset(
                          foodCoupon,
                          height: 0.2.sh,
                          width: 0.27.sw,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
