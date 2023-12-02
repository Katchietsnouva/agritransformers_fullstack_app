// import 'package:flutter/material.dart';

// class MyButton extends StatefulWidget {
//   final void Function()? onTap;
//   final String text;

//   const MyButton({
//     Key? key,
//     required this.onTap,
//     required this.text,
//   }) : super(key: key);

//   @override
//   _MyButtonState createState() => _MyButtonState();
// }

// class _MyButtonState extends State<MyButton> {
//   bool isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) {
//         setState(() {
//           isHovered = true;
//         });
//       },
//       onExit: (_) {
//         setState(() {
//           isHovered = false;
//         });
//       },
//       child: GestureDetector(
//         onTap: widget.onTap,
//         child: Ink(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25),
//             gradient: LinearGradient(
//               colors: isHovered
//                   ? [Colors.green, Colors.blue] // Change colors when hovered
//                   : [Colors.blue, Colors.green],
//             ),
//           ),
//           child: Container(
//             padding: const EdgeInsets.all(25),
//             child: Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.star, // Replace with your desired icon
//                     color: Colors.white,
//                   ),
//                   const SizedBox(width: 8), // Adjust the spacing between the icon and text
//                   Text(
//                     widget.text,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }





















import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Colors.green[400], 
            borderRadius: BorderRadius.circular(25)),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold, 
              fontSize: 16),
        )),
      ),
    );
  }
}
