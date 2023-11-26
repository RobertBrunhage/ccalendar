import 'dart:async';
import 'dart:math';

import 'package:ccalender/core/utils.dart';
import 'package:ccalender/generated/l10n.dart';
import 'package:ccalender/ui_library/styles.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Box {
  final String openedText;
  bool isOpened;

  Box({required this.openedText, this.isOpened = false});
}

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late Timer _timer;
  DateTime currentDate = DateTime.now();

  List<Box> boxes = [
    Box(
        openedText:
            '**15% off** on all avatars on [Gumroad](https://artofnessa.gumroad.com/).\n\nUse code **Advent1** on checkout. **Only 5 slots** '),
    Box(openedText: '15% off total price on commission 2 slots'),
    Box(
        openedText:
            'Free emotes when ordering a commission 2 slots (limited to 5 emotes)'),
    Box(
        openedText:
            'Free extra Christmas ugly sweater toggle VRChat avatar 1 slot'),
    Box(openedText: '\$40 Mystery box day! (bust sculpt render) 3 slots'),
    Box(
        openedText:
            'Free holiday-themed accessories/expressions for VTubers/VRChat avatars 2 slots'),
    Box(openedText: 'Fullbody sculpts 2 slots'),
    Box(openedText: 'Free VTuber setup for VRChat avatars 2 slots'),
    Box(openedText: 'Sale on gumroad 25% off on 5 avatars'),
    Box(
        openedText:
            '\$60 Mystery box day! (Lowpoly model of your sona render + files)'),
    Box(openedText: '20% off total price on commission 1 slot'),
    Box(openedText: '50% off total price on base gremlin VTuber 1 slot'),
    Box(openedText: '\$100 Lowpoly model 2 slots (renders)'),
    Box(openedText: ''),
    Box(openedText: ''),
    Box(openedText: ''),
    Box(
        openedText:
            '\$100 Mystery box day! (1 free VRChat avatar,1 fullbody sculpt) 2 slots'),
    Box(openedText: '\$300 Lowpoly VTuber avatar 1 slot'),
    Box(openedText: '30% off total price on commission 1 slot'),
    Box(openedText: ''),
    Box(openedText: ''),
    Box(openedText: ''),
    Box(openedText: ''),
    Box(openedText: 'Lunette 2.0 release + BIG sale 10 avatars'),
    Box(openedText: 'Lunette 2.0 release + smaller sale 15 avatars'),
  ];

  final popupConfettiController =
      ConfettiController(duration: const Duration(seconds: 1));
  final constantSnowController = ConfettiController();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentDate = DateTime.now();
      });
    });
    constantSnowController.play();
    for (int i = 0; i < 25; i++) {
      final isOpened =
          context.read<SharedPreferences>().getBool('box$i') ?? false;
      boxes[i].isOpened = isOpened;
    }
  }

  Future<void> _setDateOpened(int i) async {
    setState(() {
      boxes[i].isOpened = true;
    });
    await context.read<SharedPreferences>().setBool('box$i', true);
  }

  Future<void> _showConfettiDialog(BuildContext context, String text) async {
    popupConfettiController.play();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  child: MarkdownBody(
                    data: text,
                    onTapLink: (text, href, title) {
                      openUrl(href);
                    },
                    selectable: true,
                    styleSheet: MarkdownStyleSheet(
                      p: Styles$Texts.xlNormal.copyWith(
                        color: Styles$Colors.black100,
                      ),
                      a: Styles$Texts.xlNormal.copyWith(
                        color: Colors.blue,
                      ),
                      strong: Styles$Texts.xlMedium.copyWith(
                        color: Styles$Colors.black100,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                ConfettiWidget(
                  confettiController: popupConfettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  maxBlastForce: 30,
                  colors: const [Colors.amber, Colors.green],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    popupConfettiController.stop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    S.of(context).close,
                    style: Styles$Texts.smMedium.copyWith(
                      color: Styles$Colors.white100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              return Transform.translate(
                offset: const Offset(0, -20),
                child: ConfettiWidget(
                  confettiController: constantSnowController,
                  blastDirectionality: BlastDirectionality.directional,
                  blastDirection: -pi / 2,
                  numberOfParticles: 2,
                  gravity: 0.02,
                  shouldLoop: true,
                  emissionFrequency: .05,
                  colors: const [Colors.white],
                  createParticlePath: (size) {
                    return Path()
                      ..addOval(
                          Rect.fromLTWH(0, 0, size.width / 2, size.height / 2));
                  },
                ),
              );
            }),
          ),
          const SizedBox(height: 40.0),
          Text(
            S.of(context).title,
            style: Styles$Texts.mega.copyWith(color: Colors.amber),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40.0),
          if (currentDate.month == 12)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 5,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  padding: const EdgeInsets.all(8.0),
                  children: List.generate(
                    25,
                    (index) {
                      bool isOpenable = currentDate.month == 12 &&
                          currentDate.day >= index + 1;
                      final date = boxes[index];

                      return CalendarBox(
                        onTap: () {
                          if (isOpenable) {
                            _setDateOpened(index);
                            _showConfettiDialog(context, date.openedText);
                          }
                        },
                        boxColor: (isHovering) {
                          if (isHovering) {
                            return Colors.red.shade800;
                          } else if (date.isOpened) {
                            return Colors.red.shade900;
                          } else {
                            return Colors.red.shade700;
                          }
                        },
                        borderColor: Colors.amber,
                        child: Builder(builder: (context) {
                          if (date.isOpened) {
                            return const Icon(
                              Icons.done_rounded,
                              size: 30,
                              color: Colors.amber,
                            );
                          } else {
                            return Text(
                              '${index + 1}',
                              style: Styles$Texts.xxxlMedium.copyWith(
                                color:
                                    date.isOpened ? Colors.black : Colors.amber,
                              ),
                              textAlign: TextAlign.center,
                            );
                          }
                        }),
                      );
                    },
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).opensIn,
                    style: Styles$Texts.mega.copyWith(color: Colors.amber),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  CountdownWidget(
                    targetDate: DateTime(2023, 12, 1),
                    currentDate: currentDate,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  dispose() {
    popupConfettiController.dispose();
    constantSnowController.dispose();
    _timer.cancel();
    super.dispose();
  }
}

class CalendarBox extends StatefulWidget {
  const CalendarBox({
    super.key,
    this.onTap,
    required this.boxColor,
    required this.borderColor,
    required this.child,
  });

  final VoidCallback? onTap;
  final Color Function(bool isHovering) boxColor;
  final Color borderColor;
  final Widget child;

  @override
  State<CalendarBox> createState() => _CalendarBoxState();
}

class _CalendarBoxState extends State<CalendarBox> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (isHovering) {
        setState(() {
          this.isHovering = isHovering;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.boxColor.call(isHovering),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: widget.borderColor,
            width: 4.0,
          ),
        ),
        child: Center(
          child: widget.child,
        ),
      ),
    );
  }
}

class CountdownWidget extends StatefulWidget {
  const CountdownWidget(
      {super.key, required this.currentDate, required this.targetDate});

  final DateTime targetDate;
  final DateTime currentDate;

  @override
  State createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Duration _remainingTime = const Duration();

  @override
  initState() {
    super.initState();
    _calculateCountdown();
  }

  @override
  void didUpdateWidget(covariant CountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _calculateCountdown();
  }

  void _calculateCountdown() {
    Duration remainingTime = widget.targetDate.difference(widget.currentDate);

    setState(() {
      _remainingTime = remainingTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    int days = _remainingTime.inDays;
    int hours = _remainingTime.inHours % 24;
    int minutes = _remainingTime.inMinutes % 60;
    int seconds = _remainingTime.inSeconds % 60;

    return switch ((days, hours, minutes, seconds)) {
      (0, 0, 0, 0) => Text(
          '',
          style: Styles$Texts.xxxlMedium.copyWith(color: Colors.amber),
          textAlign: TextAlign.center,
        ),
      (0, 0, 0, _) => Text(
          S.of(context).secondsRemaining(seconds),
          style: Styles$Texts.xxxlMedium.copyWith(color: Colors.amber),
          textAlign: TextAlign.center,
        ),
      (0, 0, _, _) => Text(
          S.of(context).minutesRemaining(minutes, seconds),
          style: Styles$Texts.xxxlMedium.copyWith(color: Colors.amber),
          textAlign: TextAlign.center,
        ),
      (0, _, _, _) => Text(
          S.of(context).hoursRemaining(hours, minutes, seconds),
          style: Styles$Texts.xxxlMedium.copyWith(color: Colors.amber),
          textAlign: TextAlign.center,
        ),
      (_, _, _, _) => Text(
          S.of(context).allTimeRemaining(days, hours, minutes, seconds),
          style: Styles$Texts.xxxlMedium.copyWith(color: Colors.amber),
          textAlign: TextAlign.center,
        )
    };
  }
}
