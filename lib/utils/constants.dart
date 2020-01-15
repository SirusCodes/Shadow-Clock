import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' show radians;

///constant value of pi
const double PI = math.pi;

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);
