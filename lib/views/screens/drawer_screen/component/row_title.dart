// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:lekra/controllers/auth_controller.dart';
// import 'package:lekra/generated/assets.dart';
// import 'package:lekra/services/constants.dart';
// import 'package:lekra/services/theme.dart';
// import 'package:lekra/views/screens/auth_screens/login_screen.dart';
// import 'package:lekra/views/screens/dashboard/dashboard_screen.dart';
// import 'package:lekra/views/screens/dashboard/home_screen/home_screen.dart';
// import 'package:lekra/views/screens/drawer_screen/screen/change_password/change_password_screen.dart';
// import 'package:lekra/views/screens/drawer_screen/screen/contact_us/contact_us_screen.dart';
// import 'package:lekra/views/screens/drawer_screen/screen/dispute/dispute_screen/dispute_screen.dart';
// import 'package:lekra/views/screens/drawer_screen/screen/download_qr/download_qr_screen.dart';
// import 'package:lekra/views/screens/drawer_screen/screen/profile/my_profile_screen.dart';
// import 'package:lekra/views/screens/drawer_screen/screen/referral/referral_screen.dart';
// import 'package:url_launcher/url_launcher.dart';

// class RowOFTitle extends StatelessWidget {
//   final DrawerTitleRowModel drawerTitleRowModel;

//   const RowOFTitle({
//     super.key,
//     required this.drawerTitleRowModel,
//   });
//   static const String _packageName = 'com.myfoozzybusiness';

//   Future<void> _openPlayStore() async {
//     final Uri marketUri = Uri.parse('market://details?id=$_packageName');
//     final Uri webUri = Uri.parse(
//         'https://play.google.com/store/apps/details?id=$_packageName');

//     try {
//       // Try the Play Store app first
//       if (await canLaunchUrl(marketUri)) {
//         await launchUrl(marketUri, mode: LaunchMode.externalApplication);
//         return;
//       }

//       // Fallback to the web link
//       if (await canLaunchUrl(webUri)) {
//         await launchUrl(webUri, mode: LaunchMode.externalApplication);
//         return;
//       }

//       // If neither can be launched
//       showToast(
//         message: "Could not open Play Store.",
//         toastType: ToastType.error,
//       );
//     } catch (e) {
//       showToast(
//         message: "Error opening Play Store.",
//         toastType: ToastType.error,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(builder: (authController) {
//       return GestureDetector(
//         onTap: () {
//           // 1 – If item is Play Store → open Play Store and return
//           if (drawerTitleRowModel.isPlayStore == true) {
//             _openPlayStore();
//             return;
//           }

//           // 2 – Check KYC before navigating to QR screen
//           if (drawerTitleRowModel.page is DownloadQrScreen) {
//             if (!(authController.userModel?.isKYCDone ?? false)) {
//               return showToast(
//                 message: "KYC is Required",
//                 toastType: ToastType.info,
//               );
//             }
//           }

//           // 3 – Normal navigation
//           navigate(context: context, page: drawerTitleRowModel.page);

//           // 4 – Logout
//           if (drawerTitleRowModel.islogout == true) {
//             Get.find<AuthController>().logout(context);
//             return;
//           }
//         },
//         child: Row(
//           children: [
//             SvgPicture.asset(
//               drawerTitleRowModel.icon,
//               height: 24,
//               width: 24,
//             ),
//             const SizedBox(
//               width: 16,
//             ),
//             Text(
//               drawerTitleRowModel.title,
//               style: Helper(context).textTheme.bodyMedium?.copyWith(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: drawerTitleRowModel.islogout ? red : black),
//             )
//           ],
//         ),
//       );
//     });
//   }
// }

// class DrawerTitleRowModel {
//   final String icon;
//   final String title;
//   final Widget page;
//   final bool islogout;
//   final bool isPlayStore;
//   DrawerTitleRowModel({
//     required this.icon,
//     required this.title,
//     required this.page,
//     this.islogout = false,
//     this.isPlayStore = false,
//   });
// }

// List<DrawerTitleRowModel> drawerTitleList = [
//   DrawerTitleRowModel(
//       icon: Assets.svgsHome, title: "Home", page: const DashboardScreen()),
//   DrawerTitleRowModel(
//       icon: Assets.svgsPerson, title: "Profile", page: const MyProfileScreen()),
//   DrawerTitleRowModel(
//       icon: Assets.svgsImage,
//       title: "Set as Wallpaper",
//       page: const DownloadQrScreen(
//         setAsWellPaper: true,
//       )),
//   DrawerTitleRowModel(
//       icon: Assets.svgsReferralCode,
//       title: "Referral Code",
//       page: const ReferralScreen()),
//   DrawerTitleRowModel(
//       icon: Assets.svgsLock,
//       title: "Change Password",
//       page: const ChangePasswordScreen()),
//   DrawerTitleRowModel(
//       icon: Assets.svgsDispute, title: "Dispute", page: const DisputeScreen()),
//   DrawerTitleRowModel(
//       icon: Assets.svgsContactUs,
//       title: "Contact Us",
//       page: const ContactUsScreen()),
//   DrawerTitleRowModel(
//       icon: Assets.svgsAboutUs, title: "About", page: const HomeScreen()),
//   DrawerTitleRowModel(
//       icon: Assets.svgsStar,
//       title: "Rate Us",
//       page: const HomeScreen(),
//       isPlayStore: true),
//   DrawerTitleRowModel(
//     icon: Assets.svgsLogOut,
//     title: "Logout",
//     page: const LoginScreen(),
//     islogout: true,
//   ),
// ];

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:lekra/controllers/auth_controller.dart';
import 'package:lekra/generated/assets.dart';
import 'package:lekra/services/constants.dart';
import 'package:lekra/services/theme.dart';
import 'package:lekra/views/screens/auth_screens/login_screen.dart';
import 'package:lekra/views/screens/dashboard/dashboard_screen.dart';
import 'package:lekra/views/screens/dashboard/home_screen/home_screen.dart';
import 'package:lekra/views/screens/drawer_screen/screen/change_password/change_password_screen.dart';
import 'package:lekra/views/screens/drawer_screen/screen/contact_us/contact_us_screen.dart';
import 'package:lekra/views/screens/drawer_screen/screen/dispute/dispute_screen/dispute_screen.dart';
import 'package:lekra/views/screens/drawer_screen/screen/download_qr/download_qr_screen.dart';
import 'package:lekra/views/screens/drawer_screen/screen/profile/my_profile_screen.dart';
import 'package:lekra/views/screens/drawer_screen/screen/referral/referral_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class RowOFTitle extends StatelessWidget {
  final DrawerTitleRowModel drawerTitleRowModel;

  const RowOFTitle({
    super.key,
    required this.drawerTitleRowModel,
  });

  static const String _packageName = 'com.myfoozzybusiness';

  Future<void> _openPlayStore() async {
    final Uri marketUri = Uri.parse('market://details?id=$_packageName');
    final Uri webUri = Uri.parse(
        'https://play.google.com/store/apps/details?id=$_packageName');

    try {
      // Try the Play Store app first
      if (await canLaunchUrl(marketUri)) {
        await launchUrl(marketUri, mode: LaunchMode.externalApplication);
        return;
      }

      // Fallback to the web link
      if (await canLaunchUrl(webUri)) {
        await launchUrl(webUri, mode: LaunchMode.externalApplication);
        return;
      }

      showToast(
        message: "Could not open Play Store.",
        toastType: ToastType.error,
      );
    } catch (e) {
      showToast(
        message: "Error opening Play Store.",
        toastType: ToastType.error,
      );
    }
  }

  Future<void> _showRatingDialog(BuildContext context) async {
    int selected = 0;

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Rate Us'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('How would you rate our app?'),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final starIndex = index + 1;
                    return IconButton(
                      icon: Icon(
                        starIndex <= selected ? Icons.star : Icons.star_border,
                        size: 32,
                      ),
                      onPressed: () {
                        setState(() {
                          selected = starIndex;
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(height: 8),
                if (selected > 0 && selected <= 3)
                  const Text(
                    "Thanks — We'd appreciate feedback to improve!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(); // cancel
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (selected == 0) {
                    showToast(message: "Please select rating");
                    return;
                  }

                  Navigator.of(ctx).pop();

                  final InAppReview inAppReview = InAppReview.instance;

                  // Google official rating pop-up
                  try {
                    if (await inAppReview.isAvailable()) {
                      await inAppReview.requestReview();
                    }
                  } catch (_) {}

                  // Fallback open Play Store
                  await _openPlayStore();
                },
                child: const Text('Submit'),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (authController) {
      return GestureDetector(
        onTap: () {
          // 1 – Play Store -> open rating dialog
          if (drawerTitleRowModel.isPlayStore == true) {
            // _showRatingDialog(context);
            _openPlayStore();
            return;
          }

          // 2 – Check KYC before navigating to QR screen
          if (drawerTitleRowModel.page is DownloadQrScreen) {
            if (!(authController.userModel?.isKYCDone ?? false)) {
              return showToast(
                message: "KYC is Required",
                toastType: ToastType.info,
              );
            }
          }

          // 3 – Normal navigation
          navigate(context: context, page: drawerTitleRowModel.page);

          // 4 – Logout
          if (drawerTitleRowModel.islogout == true) {
            Get.find<AuthController>().logout(context);
            return;
          }
        },
        child: Row(
          children: [
            SvgPicture.asset(
              drawerTitleRowModel.icon,
              height: 24,
              width: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              drawerTitleRowModel.title,
              style: Helper(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: drawerTitleRowModel.islogout ? red : black),
            )
          ],
        ),
      );
    });
  }
}

class DrawerTitleRowModel {
  final String icon;
  final String title;
  final Widget page;
  final bool islogout;
  final bool isPlayStore;
  DrawerTitleRowModel({
    required this.icon,
    required this.title,
    required this.page,
    this.islogout = false,
    this.isPlayStore = false,
  });
}

List<DrawerTitleRowModel> drawerTitleList = [
  DrawerTitleRowModel(
      icon: Assets.svgsHome, title: "Home", page: const DashboardScreen()),
  DrawerTitleRowModel(
      icon: Assets.svgsPerson, title: "Profile", page: const MyProfileScreen()),
  DrawerTitleRowModel(
      icon: Assets.svgsImage,
      title: "Set as Wallpaper",
      page: const DownloadQrScreen(
        setAsWellPaper: true,
      )),
  DrawerTitleRowModel(
      icon: Assets.svgsReferralCode,
      title: "Referral Code",
      page: const ReferralScreen()),
  DrawerTitleRowModel(
      icon: Assets.svgsLock,
      title: "Change Password",
      page: const ChangePasswordScreen()),
  DrawerTitleRowModel(
      icon: Assets.svgsDispute, title: "Dispute", page: const DisputeScreen()),
  DrawerTitleRowModel(
      icon: Assets.svgsContactUs,
      title: "Contact Us",
      page: const ContactUsScreen()),
  DrawerTitleRowModel(
      icon: Assets.svgsAboutUs, title: "About", page: const DashboardScreen()),
  DrawerTitleRowModel(
      icon: Assets.svgsStar,
      title: "Rate Us",
      page: const HomeScreen(),
      isPlayStore: true),
  DrawerTitleRowModel(
    icon: Assets.svgsLogOut,
    title: "Logout",
    page: const LoginScreen(),
    islogout: true,
  ),
];
