/// A utility class for converting between **Gregorian** and **Jalali (Persian)** calendar dates.
///
/// This class provides two static methods:
/// - [toJalali]: Converts a Gregorian date (e.g. `2025/10/20`) to Jalali (`1404/07/28`)
/// - [toGregorian]: Converts a Jalali date (e.g. `1404/07/28`) to Gregorian (`2025/10/20`)
///
/// The methods are purely algorithmic — no external dependencies are required.
/// Leap years and month boundaries are handled according to the Jalali calendar system.
class PersianDate {
  /// Converts a **Gregorian date** to a **Jalali (Persian)** date string.
  ///
  /// ### Example:
  /// ```dart
  /// String jalali = PersianDate.toJalali(2025, 10, 20);
  /// // Output: "1404/07/28"
  ///
  /// String jalali2 = PersianDate.toJalali(2025, 1, 1, twoDigits: true);
  /// // Output: "1403/10/11"
  /// ```
  ///
  /// ### Parameters:
  /// - [y]: Gregorian year.
  /// - [m]: Gregorian month (1–12).
  /// - [d]: Gregorian day (1–31).
  /// - [twoDigits]: If `true`, pads month and day with leading zeros (e.g. `07/03`).
  /// - [separator]: Optional separator for the returned date (default is `/`).
  ///
  /// ### Returns:
  /// A formatted Jalali date string in the format `"YYYY/MM/DD"`.
  static String toJalali(int y, int m, int d,
      {bool twoDigits = false, String separator = '/'}) {
    final monthDays = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334];

    if (m < 1 || m > 12) throw ArgumentError('Month must be between 1 and 12');
    if (d < 1 || d > 31) throw ArgumentError('Day must be between 1 and 31');

    int jy;
    if (y > 1600) {
      jy = 979;
      y -= 1600;
    } else {
      jy = 0;
      y -= 621;
    }

    final gy = (m > 2) ? y + 1 : y;
    int dayCount = (365 * y) +
        ((gy + 3) ~/ 4) -
        ((gy + 99) ~/ 100) +
        ((gy + 399) ~/ 400) -
        80 +
        d +
        monthDays[m - 1];

    jy += 33 * (dayCount ~/ 12053);
    dayCount %= 12053;

    jy += 4 * (dayCount ~/ 1461);
    dayCount %= 1461;

    if (dayCount > 365) {
      jy += ((dayCount - 1) ~/ 365);
      dayCount = (dayCount - 1) % 365;
    }

    late int jm, jd;
    if (dayCount < 186) {
      jm = 1 + (dayCount ~/ 31);
      jd = 1 + (dayCount % 31);
    } else {
      jm = 7 + ((dayCount - 186) ~/ 30);
      jd = 1 + ((dayCount - 186) % 30);
    }

    twoDigits ? (jm < 10 ? '0$jm' : '$jm') : '$jm';
    twoDigits ? (jd < 10 ? '0$jd' : '$jd') : '$jd';

    return '$jy$separator$jm$separator$jd';
  }

  /// Converts a **Jalali (Persian)** date to a **Gregorian** date string.
  ///
  /// ### Example:
  /// ```dart
  /// String gregorian = PersianDate.toGregorian(1404, 7, 28);
  /// // Output: "2025/10/20"
  ///
  /// String gregorian2 = PersianDate.toGregorian(1403, 10, 11, separator: '-');
  /// // Output: "2025-01-01"
  /// ```
  ///
  /// ### Parameters:
  /// - [y]: Jalali year.
  /// - [m]: Jalali month (1–12).
  /// - [d]: Jalali day (1–31).
  /// - [twoDigits]: If `true`, pads month and day with leading zeros (e.g. `07/03`).
  /// - [separator]: Optional separator for the returned date (default is `/`).
  ///
  /// ### Returns:
  /// A formatted Gregorian date string in the format `"YYYY/MM/DD"`.
  static String toGregorian(int y, int m, int d,
      {bool twoDigits = false, String separator = '/'}) {
    if (m < 1 || m > 12) throw ArgumentError('Month must be between 1 and 12');
    if (d < 1 || d > 31) throw ArgumentError('Day must be between 1 and 31');

    int gy;
    if (y > 979) {
      gy = 1600;
      y -= 979;
    } else {
      gy = 621;
    }

    int days = (365 * y) +
        ((y ~/ 33) * 8) +
        (((y % 33) + 3) ~/ 4) +
        78 +
        d +
        ((m < 7) ? (m - 1) * 31 : ((m - 7) * 30 + 186));

    gy += 400 * (days ~/ 146097);
    days %= 146097;

    if (days > 36524) {
      gy += 100 * (--days ~/ 36524);
      days %= 36524;
      if (days >= 365) days++;
    }

    gy += 4 * (days ~/ 1461);
    days %= 1461;

    if (days > 365) {
      gy += ((days - 1) ~/ 365);
      days = (days - 1) % 365;
    }

    int gd = days + 1;

    final gMonthDays = [
      0,
      31,
      ((gy % 4 == 0 && gy % 100 != 0) || (gy % 400 == 0)) ? 29 : 28,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];

    int gm = 0;
    while (gm < 12 && gd > gMonthDays[++gm]) {
      gd -= gMonthDays[gm];
    }

    twoDigits ? (gm < 10 ? '0$gm' : '$gm') : '$gm';
    twoDigits ? (gd < 10 ? '0$gd' : '$gd') : '$gd';

    return '$gy$separator$gm$separator$gd';
  }
}
