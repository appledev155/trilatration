import 'dart:async';
import 'package:flutter/material.dart';

class ZonePage extends StatefulWidget {
  const ZonePage({Key? key}) : super(key: key);

  @override
  State<ZonePage> createState() => _ZonePageState();
}

class _ZonePageState extends State<ZonePage> {
  // Example coordinates fetched from API
  List<Offset> coordinates = [
    // const Offset(15.02, 1.77),
    const Offset(65.51, 2.35),
    const Offset(101.02, 100.77),
    // const Offset(90.08, 112.38),
    const Offset(165.08, 122.38),
  ];

  int currentIndex = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % coordinates.length;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 45, 15, 15),
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
        height: MediaQuery.of(context).size.height - 8,
        width: MediaQuery.of(context).size.width - 8,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 186, 214, 236),
            border: Border.all(
                width: 1, color:  Colors.red),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Stack(
          children: [
            Positioned(
                left: 20,
                top: 100,
                right: 100,
                bottom: 200,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Stack(
                      children: [
                        CustomPaint(
                          painter: GraphPainter(coordinates),
                        ),
                        Positioned(
                          left: coordinates[currentIndex].dx,
                          top: coordinates[currentIndex].dy,
                          child: BlinkingTracker(
                            coordinate: coordinates[currentIndex],
                          ),
                        ),
                        const Positioned(
                          bottom: 10,
                          left: 10,
                          child: Text(
                            'Room 1',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ))),
            const Positioned(
              top: 5,
              left: 5,
              child: Text(
                'Zone 1',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  final List<Offset> coordinates;

  GraphPainter(this.coordinates);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    for (var i = 0; i < coordinates.length - 1; i++) {
      // canvas.drawLine(coordinates[i], coordinates[i + 1], linePaint);
      canvas.drawCircle(coordinates[i], 5.0, dotPaint); // Draw blue dot
    }

    canvas.drawCircle(coordinates[coordinates.length - 1], 5.0,
        dotPaint); // Draw dot for the last coordinate
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BlinkingTracker extends StatefulWidget {
  final Offset coordinate;
  const BlinkingTracker({Key? key, required this.coordinate}) : super(key: key);

  @override
  State<BlinkingTracker> createState() => _BlinkingTrackerState();
}

class _BlinkingTrackerState extends State<BlinkingTracker> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        isVisible = !isVisible;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
            visible: isVisible,
            child: const Icon(
              Icons.track_changes_sharp,
              color: Colors.red,
            )),
      ],
    );
  }
}

 









 // Text(
                //   ('x=${widget.coordinate.dx},'
                //       "\n"
                //       'y= ${widget.coordinate.dy}'),
                //   style: const TextStyle(color: Colors.black),
                // ),
                //  Text(
                //   '(F8F9B942D63B)',
                //   style: TextStyle(color: Colors.black),
                // ),











































































































































































































































































// import 'dart:async';
// import 'package:flutter/material.dart';

// class ZonePage extends StatefulWidget {
//   const ZonePage({Key? key}) : super(key: key);

//   @override
//   State<ZonePage> createState() => _ZonePageState();
// }

// class _ZonePageState extends State<ZonePage> {
//   bool isVisible = true;

//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(const Duration(milliseconds: 500), (timer) {
//       setState(() {
//         isVisible = !isVisible;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.fromLTRB(10, 45, 15, 15),
//         padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
//         height: MediaQuery.of(context).size.height - 8,
//         width: MediaQuery.of(context).size.width - 8,
//         decoration: const BoxDecoration(
//             color: Colors.black12,
//             borderRadius: BorderRadius.all(Radius.circular(8))),
//         child: Stack(
//           children: [
//             Positioned(
//               left: 10,
//               top: 10,
//               right: 160,
//               bottom: 450,
//               child: AnimatedOpacity(
//                 opacity: isVisible ? 1.0 : 0.0,
//                 duration: const Duration(milliseconds: 500),
//                 child: Container(
//                     decoration: const BoxDecoration(
//                         color: Color.fromARGB(255, 147, 240, 162)),
//                     child: TextButton.icon(
//                         onPressed: () {},
//                         icon: const Icon(
//                           semanticLabel: "Tracker",
//                           Icons.track_changes_sharp,
//                           color: Color.fromARGB(255, 42, 135, 211),
//                         ),
//                         label: const Text("Tracker"))),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }