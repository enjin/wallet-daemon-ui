import 'package:enjin_wallet_daemon/core/app_export.dart';
import 'package:enjin_wallet_daemon/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';

import '../../../main.dart';
import '../../../services/store_service.dart';

class OnboardController extends GetxController {
  static OnboardController get to => Get.find();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatController = TextEditingController();

  Future<void> setPassword() async {
    if (passwordController.text != repeatController.text ||
        passwordController.text.length < 16) {
      return;
    }

    final store = getIt.get<StoreService>();
    await store.init(passwordController.text);

    Get.offNamed(Routes.main.nameToRoute());
  }
}

//                   setState(() {});
//                 },
//                 decoration: InputDecoration(
//                   errorText: passwordController.text.length < 16 &&
//                       passwordController.text != ''
//                       ? 'Password must be at least 16 characters long'
//                       : null,
//                   contentPadding: const EdgeInsets.only(left: 10, right: 10),
//                   hintText: 'Input the password',
//                   border: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       width: 1,
//                       color: Color(0xFF7567CE),
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             SizedBox(
//               width: 480,
//               child: TextField(
//                 controller: repeatController,
//                 obscureText: true,
//                 onChanged: (text) => setState(() {}),
//                 decoration: InputDecoration(
//                   errorText: repeatController.text != '' &&
//                       repeatController.text != passwordController.text
//                       ? 'Passwords do not match'
//                       : null,
//                   contentPadding: const EdgeInsets.only(left: 10, right: 10),
//                   hintText: 'Repeat the password',
//                   border: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                       width: 1,
//                       color: Color(0xFF7567CE),
//                     ),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ),
//             const Spacer(),
//           ],
//         ),
//         _ => SvgPicture.asset('lib/assets/undraw_launch.svg'),
//       };
//     }
//
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: PageView.builder(
//               controller: controller,
//               itemCount: 3,
//               itemBuilder: (_, index) => _getPage(_, index),
//             ),
//           ),
//           SizedBox(
//             height: 30,
//             child: SmoothPageIndicator(
//               controller: controller,
//               count: 3, //pages.length,
//               effect: const ExpandingDotsEffect(
//                 dotHeight: 16,
//                 dotWidth: 16,
//                 activeDotColor: Color(0xFF7866D5),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 32,
//           ),
//           SizedBox(
//             width: 180,
//             height: 48,
//             child: MaterialButton(
//               onPressed: currentPage == 2 &&
//                   (passwordController.text != repeatController.text ||
//                       passwordController.text.length < 16)
//                   ? null
//                   : () async {
//                 if (currentPage == 2) {
//
//
//
//
//                   return;
//                 }
//
//                 setState(() {
//                   currentPage++;
//                 });
//
//                 controller.nextPage(
//                     duration: const Duration(milliseconds: 500),
//                     curve: Curves.easeInOut);
//               },
//               disabledColor: const Color(0xFF7866D5).withOpacity(0.3),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               color: const Color(0xFF7866D5),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 currentPage == 2 ? "Confirm" : "Next",
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 32,
//           ),
//         ],
//       ),
//     );
//   }
// }
