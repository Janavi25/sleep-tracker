import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void changeScreen(BuildContext context, Widget widget) {
  // Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  Navigator.push(
    context,
    PageTransition(
      child: widget,
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 280),
    ),
  );
}

// request here
void changeScreenReplacement(BuildContext context, Widget widget) {
  // Navigator.pushReplacement(
  //     context, MaterialPageRoute(builder: (context) => widget));
  Navigator.pushReplacement(
      context,
      PageTransition(
        child: widget,
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 280),
      ));
}

void nohistorychangescreen(BuildContext context, Widget widget) {
  // Navigator.pushAndRemoveUntil(
  //     context, MaterialPageRoute(builder: (context) => widget), (_) => false);
  Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: widget,
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 280),
      ),
      (_) => false);
}

// void animatedchange(BuildContext context, Widget widget) {
//   Route scaleIn(Widget page) {
//     return PageRouteBuilder(
//       transitionDuration: const Duration(milliseconds: 500),
//       pageBuilder: (context, animation, secondaryAnimation) => page,
//       transitionsBuilder: (context, animation, secondaryAnimation, page) {
//         var begin = 0.0;
//         var end = 1.0;
//         var curve = Curves.ease;

//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//         return ScaleTransition(
//           scale: animation.drive(tween),
//           child: page,
//         );
//       },
//     );
//   }

//   Navigator.push(context, scaleIn(widget));
// }
