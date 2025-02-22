import 'package:flutter/material.dart';
import 'package:take_a_break/take_a_break.dart';

class BreakScreen extends StatefulWidget {
  const BreakScreen({super.key, this.duration, required this.username});

  final Duration? duration;

  final String username;

  @override
  State<BreakScreen> createState() => _BreakScreenState();
}

class _BreakScreenState extends State<BreakScreen> {
  bool _isCompleted = false;
  bool _isCancelled = false;
  late DateTime currentTime;
  late DateTime breakEndsAt;
  @override
  void initState() {
    currentTime=DateTime.now();
    breakEndsAt=currentTime.add(widget.duration??Duration.zero);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
            },
            padding: EdgeInsets.zero,
            icon: Image.asset(
              AssetConstants.hamburgerMenu,
              height: 24,
              width: 24,
            )),
        actions: [
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Color(0xFFD8DAE5), width: 1),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AssetConstants.help,
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    ButtonTextConstants.help,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.24,
                        color: Color(0xFFF5FBF8)),
                  ),
                ],
              )),
          const SizedBox(
            width: 24,
          ),
          IconButton(
              onPressed: () async{
                 SharedPreferencesService().deletePath();
                Navigator.pop(context);
              },
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFF8F95B2), width: 1))),
              icon: Image.asset(
                AssetConstants.steamingTea,
                height: 24,
                width: 24,
              )),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            // top: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 279,
                width: double.maxFinite,
                color: Color(0xFF314B71),
                child: Stack(
                  children: [
                    Positioned(
                      top: -299,
                      left: -277,
                      child: CircleAvatar(
                        radius: 312,
                        backgroundColor: Color(0xFF38547D),
                      ),
                    ),
                    Positioned(
                      top: -167,
                      left: -148,
                      child: CircleAvatar(
                        radius: 198,
                        backgroundColor: Color(0xFF3E5E8C),
                      ),
                    ),
                    Positioned(
                      top: -88,
                      left: -70,
                      child: CircleAvatar(
                        radius: 118,
                        backgroundColor: Color(0xFF436596),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, kTextTabBarHeight * 2, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, ${widget.username}!',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.24,
                      color: Color(0xFFF5FBF8)),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'You are on break!',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.24,
                      color: Color(0xFFF5FBF8)),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(colors: [
                        Color(0xFF803FD7),
                        Color(0xFF3057D8),
                        Color(0xFF3B80C1)
                      ], stops: [
                        -0.068,
                        0.4621,
                        0.9899
                      ], begin: Alignment.topLeft)),
                  // height: 504,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(16),
                  child: _isCompleted
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 64,
                            ),
                            SizedBox(height: 20,),
                            Container(
                              height: 123,
                              width: 123,
                              alignment: Alignment.center,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAnimation(
                                    isAnimating: true,
                                    startSize: 72,
                                    endSize: 123,
                                    color: Colors.white10,
                                  ),
                                  CircleAnimation(
                                    isAnimating: true,
                                    startSize: 72,
                                    endSize: 103,
                                    color: Colors.white38,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 72,
                                    width: 72,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    // child: Icon(
                                    //  _isCancelled?Icons.close : Icons.check,
                                    //   size: 24,
                                    //   color: Color(0xFF494FD8),
                                    // ),
                                    child: Image.asset(
                                      _isCancelled?AssetConstants.cancelled:AssetConstants.completed,
                                      height: 24,width: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                             _isCancelled?"You cancelled your break": "Hope you are feeling refreshed and ready to start working again",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.24,
                                  color: Color(0xFFF5FBF8)),
                            ),
                            const SizedBox(
                              height: 52,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "We value your hard work!\n"
                              "Take this time to relax",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.24,
                                  color: Color(0xFFF5FBF8)),
                            ),
                            TimerAnimation(
                              duration: widget.duration,
                              onCompletion: () {
                                setState(() {
                                  _isCompleted = true;
                                });
                              },
                            ),
                            // const SizedBox(height: 16,),
                            Container(
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Color(0xFFACC4E8CC)
                                              .withValues(alpha: 0.8),
                                          width: 0.618),
                                      bottom: BorderSide(
                                          color: Color(0xFFACC4E8CC)
                                              .withValues(alpha: 0.8),
                                          width: 0.618))),
                              alignment: Alignment.center,
                              child: Text(
                                "Break ends at 01:30 PM",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.24,
                                    color: Color(0xFFF5FBF8)),
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight: 48, maxWidth: double.maxFinite),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight:
                                                      Radius.circular(16))),
                                          showDragHandle: true,
                                          builder: (BuildContext context) {
                                            return DraggableScrollableSheet(
                                              initialChildSize: 0.4,
                                              minChildSize: 0.27,
                                              // maxChildSize: 0.9,
                                              maxChildSize: 0.5,
                                              expand: false,
                                              builder: (BuildContext context,
                                                  ScrollController
                                                      scrollController) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 0, 16, 16),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "Ending break early?",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            letterSpacing: 0,
                                                            color: Color(
                                                                0xFF101840)),
                                                      ),
                                                      const SizedBox(
                                                        height: 16,
                                                      ),
                                                      Text(
                                                        "Are you sure you want to end your break now? Take this time to recharge before your next task.",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing: 0,
                                                            color: Color(
                                                                0xFF525871)),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 16.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        style: TextButton.styleFrom(
                                                                            backgroundColor:
                                                                                Color(0xFF429777),
                                                                            shape: RoundedRectangleBorder(side: BorderSide(color: Color(0xFF429777), width: 1), borderRadius: BorderRadius.circular(8)),
                                                                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8)),
                                                                        child: Text(
                                                                          ButtonTextConstants
                                                                              .continueForward,
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w600,
                                                                              letterSpacing: -0.24,
                                                                              color: Colors.white),
                                                                        ))),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Expanded(
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            _isCancelled =
                                                                                true;
                                                                            _isCompleted =
                                                                                true;
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        style: TextButton.styleFrom(
                                                                            shape:
                                                                                RoundedRectangleBorder(side: BorderSide(color: Color(0xFFA73636), width: 1), borderRadius: BorderRadius.circular(8)),
                                                                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8)),
                                                                        child: Text(
                                                                          ButtonTextConstants
                                                                              .endNow,
                                                                          style: TextStyle(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w600,
                                                                              letterSpacing: -0.24,
                                                                              color: Color(0xFFA73636)),
                                                                        )))
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFFD14343),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14.5)),
                                      child: Text(
                                        ButtonTextConstants.endBreak,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            )
                          ],
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
