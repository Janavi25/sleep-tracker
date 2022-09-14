import 'dart:math' show cos, sqrt, asin;

String difference(int seco) {
  int hours = (seco / 3600).floor();
  int min = ((seco - hours * 60 * 60) / 60).floor();
  int sec = seco - min * 60 - hours * 60 * 60;
  String ans = hours.toString().padLeft(2, '0') +
      " : " +
      min.toString().padLeft(2, '0') +
      " : " +
      sec.toString().padLeft(2, '0');
  return ans;
}

String timedate(DateTime dt) {
  return '${dt.day}-${getMonth(dt.month)}-${dt.year % 1000} ${dt.hour == 0 ? 12 : dt.hour > 12 ? dt.hour - 12 : dt.hour}:${dt.minute < 10 ? '0${dt.minute}' : dt.minute} ${dt.hour < 12 ? 'AM' : 'PM'}';
}

String greetings(DateTime dt) {
  int h = dt.hour;
  if (h < 5 || h >= 21) {
    return 'Good Night';
  } else if (h >= 5 && h < 12) {
    return 'Good Morning';
  } else if (h >= 12 && h < 17) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

String timeperiod(int sec) {
  int min, hrs, day, week;
  if (sec > 59) {
    min = Duration(seconds: sec).inMinutes;

    if (min > 59) {
      hrs = Duration(seconds: sec).inHours;
      if (hrs > 24) {
        day = Duration(seconds: sec).inDays;
        if (day > 7) {
          week = (day ~/ 7);

          return (week.toString() + "w");
        } else {
          return (day.toString() + "d");
        }
      } else {
        return (hrs.toString() + "h");
      }
    } else {
      return (min.toString() + "m");
    }
  } else {
    return (sec.toString() + "s");
  }
}

String getMonth(int i) {
  switch (i) {
    case 1:
      return "JAN";
    case 2:
      return "FEB";
    case 3:
      return "MAR";
    case 4:
      return "APR";
    case 5:
      return "MAY";
    case 6:
      return "JUN";
    case 7:
      return "JUL";
    case 8:
      return "AUG";
    case 9:
      return "SEP";
    case 10:
      return "OCT";
    case 11:
      return "NOV";
    case 12:
      return "DEC";
  }
  return "i";
}
// double _coordinateDistance(lat1, lon1, lat2, lon2) {
//   var p = 0.017453292519943295;
//   var c = cos;
//   var a = 0.5 -
//       c((lat2 - lat1) * p) / 2 +
//       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//   return 12742 * asin(sqrt(a));
// }

bool getOpenStatus(dynamic a) {
  DateTime now = DateTime.now();
  int l = a['${now.weekday}'].length;
  bool open = false;
  for (int i = 0; i < l; i++) {
    if (now.hour >= a['${now.weekday}'][i]['open'] &&
        now.hour <= a['${now.weekday}'][i]['close']) {
      if (now.hour == a['${now.weekday}'][i]['open'] &&
          now.minute < a['${now.weekday}'][i]['openMinute']) {
        open = false;
        break;
      } else if (now.hour == a['${now.weekday}'][i]['close'] &&
          now.minute > a['${now.weekday}'][i]['closeMinute']) {
        open = false;
        break;
      } else {
        open = true;
        break;
      }
    }
  }
  return open;
}
