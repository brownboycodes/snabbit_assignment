import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TimerAnimation extends StatefulWidget {
  const TimerAnimation({super.key,required this.duration,required this.onCompletion});
  final Duration duration;
  final VoidCallback onCompletion;

  @override
  State<TimerAnimation> createState() => _TimerAnimationState();
}

class _TimerAnimationState extends State<TimerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration, // Duration of one cycle
    )..forward();
_controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onCompletion();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Stack(
        children: [
          Positioned(
            left: 49,
            top: 10,
            child: Transform.rotate(
                angle: -19.12,
                child: Icon(
                  Icons.star,
                  size: 26,
                  color: const Color(0xFFF7F6F226).withValues(alpha: 0.15),
                )),
          ),
          Positioned(
            left: 43,
            top: 149 + 26,
            child: Transform.rotate(
                angle: 170.42,
                child: Icon(
                  Icons.star,
                  size: 26,
                  color: const Color(0xFFF7F6F21A).withValues(alpha: 0.1),
                )),
          ),
          Positioned(
            right: 57,
            top: 7,
            child: Transform.rotate(
                angle: 0.59,
                child: Icon(
                  Icons.star,
                  size: 14.93,
                  color: const Color(0xFFF7F6F233).withValues(alpha: 0.2),
                )),
          ),
          Positioned(
            right: 57,
            top: 149 + 14.93,
            child: Transform.rotate(
                angle: -160.88,
                child: Icon(
                  Icons.star_outline_rounded,
                  size: 26,
                  color: const Color(0xFFF7F6F21A).withValues(alpha: 0.1),
                )),
          ),
          SizedBox(
            height: 200,
            child: AnimatedBuilder(
              // animation: _animation,
              animation: _controller,
              builder: (context, child) {
                return SfRadialGauge(
                  axes: [
                    RadialAxis(
                      showLabels: false,
                      showTicks: false,
                      pointers: <GaugePointer>[
                        RangePointer(
                          // value: _animation.value.inSeconds/60,
                          value: _controller.value*100,
                          cornerStyle: CornerStyle.endCurve,
                          width: 16,
                          color: Colors.white,
                          // sizeUnit: GaugeSizeUnit.factor,
                        )
                      ],
                      axisLineStyle: AxisLineStyle(
                        color: Color(0xFF738DD7),
                        thickness: 16,
                      ),
                      startAngle: 120,
                      endAngle: 60,
                      annotations: [
                        GaugeAnnotation(
                            widget: Text(
                          getTimeLeft(_controller.value),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.24,
                              color: Color(0xFFF5FBF8)),
                        )),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Transform.translate(
                offset: Offset(0, -6.18),
                child: Text(
                  "Break",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.24,
                      color: Color(0xFFFFFFFE)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  
  String getTimeLeft(double percentage){
    final totalSecondsLeft = (widget.duration.inSeconds*(1-percentage)).toInt();
    int seconds=totalSecondsLeft;
    String time="";
    if(totalSecondsLeft>59){
      int minutes = totalSecondsLeft~/60;
      seconds=totalSecondsLeft - (minutes*60);
      if(minutes<10){
        time="0$minutes";
      }else{
        time="$minutes";
      }
    }
    if(time.isEmpty){
      time="00";
    }
    time+=":";
    if(seconds<10){
      time+="0$seconds";
    }else{
      time+="$seconds";
    }
    return time;
  }
}
