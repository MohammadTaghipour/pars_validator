import 'dart:math';

/// A utility class for working with Iranian National utilities.
///
/// This class provides methods for validating a National ID,
/// generating a random valid National ID, and retrieving the issuance
/// location based on the National ID and etc.
///
/// ## Usage Example:
///
/// ```dart
/// // Validate a National ID
/// bool isValid = National.isNationalIDValid("1234567891");
///
/// // Generate a random valid National ID
/// String randomID = National.generateRandomID();
///
/// // Get the issuance location of a National ID
/// String? issuance = National.getIssuance("1234567891");
/// ```
class National {
  /// Validates an Iranian National ID.
  ///
  /// Checks the given [nationalCode] for the correct format and
  /// verifies the checksum to determine if it is valid.
  ///
  /// - [nationalCode]: The National ID to validate (a 10-digit string).
  ///
  /// Returns `true` if the National ID is valid; otherwise, returns `false`.
  ///
  /// ```dart
  /// bool isValid = National.isNationalIDValid("1234567891");
  /// ```
  static bool isNationalIDValid(String nationalCode) {
    if (nationalCode.length != 10 ||
        !RegExp(r'^\d{10}$').hasMatch(nationalCode)) {
      return false;
    }

    final repetitiveCodes = [
      "0000000000",
      "1111111111",
      "2222222222",
      "3333333333",
      "4444444444",
      "5555555555",
      "6666666666",
      "7777777777",
      "8888888888",
      "9999999999"
    ];
    if (repetitiveCodes.contains(nationalCode)) {
      return false;
    }

    int controlDigit = int.parse(nationalCode[9]);

    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(nationalCode[i]) * (10 - i);
    }

    int remainder = sum % 11;

    return (remainder < 2 && controlDigit == remainder) ||
        (remainder >= 2 && controlDigit == (11 - remainder));
  }

  /// Generates a random valid Iranian National ID.
  ///
  /// This method creates a 10-digit valid National ID by generating
  /// 9 random digits and calculating the checksum for validity.
  ///
  /// Returns a valid National ID as a [String].
  ///
  /// ```dart
  /// String randomID = National.generateRandomID();
  /// ```
  static String generateRandomID() {
    final random = Random();
    List<int> randomDigits = List.generate(9, (_) => random.nextInt(10));
    int checksum = 0;
    for (int i = 0; i < 9; i++) {
      checksum += randomDigits[i] * (10 - i);
    }
    checksum %= 11;
    int controlDigit = checksum < 2 ? checksum : 11 - checksum;
    String nationalCode = randomDigits.join() + controlDigit.toString();
    if (!isNationalIDValid(nationalCode)) {
      return generateRandomID();
    } else {
      return nationalCode;
    }
  }

  /// Retrieves the issuance location of a National ID.
  ///
  /// Based on the first three digits of the [nationalCode], this method
  /// determines the city or province where the National ID was issued.
  ///
  /// - [nationalCode]: The National ID to analyze (a 10-digit string).
  ///
  /// Returns the name of the issuance location as a [String], or `null`
  /// if the location cannot be determined.
  ///
  /// ```dart
  /// String? issuance = National.getIssuance("1234567891");
  /// ```
  static String? getIssuance(String nationalCode) {
    if (isNationalIDValid(nationalCode)) {
      String codePrefix = nationalCode.substring(0, 3);
      return _placeOfIssueMap[codePrefix];
    }
    return null;
  }

  /// Validates whether the given postal code matches the expected format.
  ///
  ///
  /// ### Example:
  /// ```dart
  /// bool isValid = National.isValidPostalCode("1918934354"); // true
  ///
  /// isValid = National.isValidPostalCode("1111111111"); // false
  /// ```
  ///
  /// ### Parameters:
  /// - [postalCode]: The input postal code to validate.
  ///
  /// ### Returns:
  /// - `true` if the postal code matches the specified pattern.
  /// - `false` otherwise.
  static bool isValidPostalCode(String postalCode) {
    final regex = RegExp(r'\b(?!(\d)\1{3})[13-9]{4}[1346-9][013-9]{5}\b',
        caseSensitive: false);
    return regex.hasMatch(postalCode);
  }

  /// Validates if a given Iranian legal national ID is valid.
  ///
  /// This function checks whether an 11-digit legal national ID conforms to the
  /// official Iranian validation algorithm.
  ///
  /// Parameters:
  /// - [nationalID]: A string representing the national ID of a company to validate.
  ///
  /// Returns:
  /// - `true` if the national ID is valid.
  /// - `false` otherwise.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = National.isLegalNationalID('10380284790');// true
  /// ```
  static bool isLegalNationalID(String nationalID) {
    int L = nationalID.length;

    if (L < 11 || int.parse(nationalID) == 0) return false;

    if (int.parse(nationalID.substring(3, 9)) == 0) return false;

    int c = int.parse(nationalID.substring(10, 11));
    int d = int.parse(nationalID.substring(9, 10)) + 2;
    List<int> z = [29, 27, 23, 19, 17];
    int s = 0;

    for (int i = 0; i < 10; i++) {
      s += (d + int.parse(nationalID.substring(i, i + 1))) * z[i % 5];
    }

    s = s % 11;
    if (s == 10) s = 0;

    return c == s;
  }
}

// محل صدور شناسنامه
final Map<String, String> _placeOfIssueMap = {
  "169": "آذرشهر",
  "170": "اسکو",
  "149": "اهر",
  "150": "اهر",
  "171": "بستان آباد",
  "168": "بناب",
  "136": "تبریز",
  "137": "تبریز",
  "138": "تبریز",
  "545": "ترکمانچای",
  "505": "جلفا",
  "636": "چاروایماق",
  "164": "سراب",
  "165": "سراب",
  "172": "شبستر",
  "623": "آزادشهر",
  "506": "عجب شیر",
  "519": "کلیبر",
  "154": "مراغه",
  "155": "مراغه",
  "567": "ورزقان",
  "173": "هریس",
  "159": "هشترود",
  "160": "هشترود",
  "604": "هوراند",
  "274": "ارومیه",
  "275": "ارومیه",
  "295": "اشنویه",
  "637": "انزل",
  "292": "بوکان",
  "492": "پلدشت",
  "289": "پیرانشهر",
  "677": "تخت سلیمان",
  "294": "تکاب",
  "493": "چایپاره",
  "279": "خوی",
  "280": "خوی",
  "284": "سلماس",
  "285": "سلماس",
  "288": "مینودشت",
  "638": "سیلوانه",
  "291": "سیه چشمه(چالدران)",
  "640": "شوط",
  "293": "شاهین دژ",
  "675": "کشاورز",
  "282": "ماکو",
  "283": "ماکو",
  "286": "مهاباد",
  "287": "مهاباد",
  "296": "میاندوآب",
  "297": "میاندوآب",
  "290": "نقده",
  "400": "اسدآباد",
  "401": "اسدآباد",
  "405": "بهار",
  "404": "بهار",
  "398": "رزن",
  "399": "رزن",
  "397": "تویسرکان",
  "647": "شراء و پیشخوار",
  "502": "فامنین",
  "584": "قلقل رود",
  "402": "کبودرآهنگ",
  "403": "کبودرآهنگ",
  "392": "ملایر",
  "393": "ملایر",
  "395": "نهاوند",
  "396": "نهاوند",
  "386": "همدان",
  "387": "همدان",
  "503": "ابرکوه",
  "444": "اردکان",
  "551": "اشکذر",
  "447": "بافق",
  "561": "بهاباد",
  "445": "تفت",
  "718": "دستگردان",
  "083": "طبس",
  "446": "مهریز",
  "448": "میبد",
  "552": "نیر",
  "543": "هرات و مروست",
  "442": "یزد",
  "443": "یزد",
  "051": "آشتیان",
  "052": "اراک",
  "053": "اراک",
  "058": "تفرش",
  "055": "خمین",
  "617": "خنداب",
  "057": "دلیجان",
  "618": "زرند مرکزی",
  "059": "ساوه",
  "060": "ساوه",
  "061": "سربند",
  "062": "سربند",
  "544": "فراهان",
  "056": "محلات",
  "571": "وفس",
  "593": "عمارلو",
  "667": "ابوموسی",
  "348": "بستک",
  "586": "بشاگرد",
  "338": "بندرعباس",
  "339": "بندرعباس",
  "343": "بندرلنگه",
  "344": "بندرلنگه",
  "346": "جاسک",
  "337": "قصرشیرین",
  "554": "خمیر",
  "469": "رودان",
  "537": "فین",
  "345": "قشم",
  "470": "گاوبندی",
  "341": "میناب",
  "342": "میناب",
  "484": "ازنا",
  "557": "اشترینان",
  "418": "الشتر",
  "416": "الیگودرز",
  "417": "الیگودرز",
  "412": "بروجرد",
  "413": "بروجرد",
  "592": "پاپی",
  "612": "چغلوندی",
  "613": "چگنی",
  "406": "خرم آباد",
  "407": "خرم آباد",
  "213": "آمل",
  "214": "آمل",
  "205": "بابل",
  "206": "بابل",
  "498": "بابل",
  "421": "دورود",
  "598": "رومشکان",
  "419": "کوهدشت",
  "385": "دیواندره",
  "420": "نورآباد(دلفان)",
  "528": "ویسیان",
  "568": "بندپی",
  "711": "بندپی شرقی",
  "217": "بهشهر",
  "218": "بهشهر",
  "221": "تنکابن",
  "582": "جویبار",
  "483": "چالوس",
  "625": "چمستان",
  "576": "چهاردانگه",
  "578": "دودانگه",
  "227": "رامسر",
  "208": "ساری",
  "209": "ساری",
  "225": "سوادکوه",
  "577": "شیرگاه",
  "712": "عباس آباد",
  "215": "قائمشهر",
  "216": "قائمشهر",
  "626": "کجور",
  "627": "کلاردشت",
  "579": "گلوگاه",
  "713": "میاندورود",
  "499": "نکاء",
  "222": "نور",
  "219": "نوشهر",
  "220": "نوشهر",
  "500": "هراز و محمودآباد",
  "501": "هراز و محمودآباد",
  "497": "آق قلا",
  "223": "بندرترکمن",
  "689": "بندرگز",
  "487": "رامیان",
  "226": "علی آباد",
  "224": "کردکوی",
  "211": "گرگان",
  "212": "گرگان",
  "628": "گمیشان",
  "202": "گنبد کاووس",
  "203": "گنبد کاووس",
  "531": "مراوه تپه",
  "261": "آستارا",
  "273": "آستانه",
  "630": "املش",
  "264": "بندرانزلی",
  "518": "خمام",
  "631": "رحیم آباد",
  "258": "رشت",
  "259": "رشت",
  "570": "رضوانشهر",
  "265": "رودبار",
  "268": "رودسر",
  "269": "رودسر",
  "653": "سنگر",
  "517": "سیاهکل",
  "569": "شفت",
  "267": "صومعه سرا",
  "262": "طالش",
  "263": "طالش",
  "266": "فومن",
  "693": "کوچصفهان",
  "271": "لاهیجان",
  "272": "لاهیجان",
  "694": "لشت نشاء",
  "270": "لنگرود",
  "516": "ماسال و شاندرمن",
  "333": "اسلام آباد",
  "334": "اسلام آباد",
  "691": "باینگان",
  "323": "پاوه",
  "322": "پاوه",
  "595": "ثلاث باباجانی",
  "641": "حمیل",
  "596": "روانسر",
  "336": "سرپل ذهاب",
  "335": "سنقر",
  "496": "صحنه",
  "325": "کرمانشاه",
  "324": "کرمانشاه",
  "394": "کرند",
  "330": "کنگاور",
  "332": "گیلانغرب",
  "331": "هرسین",
  "687": "باشت",
  "422": "بویراحمد(یاسوج)",
  "423": "بویراحمد(یاسوج)",
  "599": "بهمنی",
  "600": "چاروسا",
  "688": "دروهان",
  "424": "کهکیلویه(دهدشت)",
  "425": "کهکیلویه(دهدشت)",
  "426": "گچساران(دوگنبدان)",
  "550": "لنده",
  "697": "مارگون",
  "377": "بانه",
  "378": "بیجار",
  "384": "بیجار",
  "558": "دهگلان",
  "646": "سروآباد",
  "375": "سقز",
  "376": "سقز",
  "372": "سنندج",
  "373": "سنندج",
  "379": "قروه",
  "380": "قروه",
  "674": "کرانی",
  "381": "مریوان",
  "382": "مریوان",
  "383": "کامیاران",
  "676": "نمشیر",
  "722": "ارزونیه",
  "542": "انار",
  "312": "بافت",
  "313": "بافت",
  "317": "بردسیر",
  "310": "بم",
  "311": "بم",
  "583": "رابر",
  "321": "راور",
  "304": "رفسنجان",
  "305": "رفسنجان",
  "536": "رودبار کهنوج",
  "605": "ریگان",
  "308": "زرند",
  "309": "زرند",
  "306": "سیرجان",
  "307": "سیرجان",
  "319": "شهداد",
  "314": "شهربابک",
  "606": "عنبرآباد",
  "320": "فهرج",
  "698": "قلعه گنج",
  "298": "کرمان",
  "299": "کرمان",
  "315": "کهنوج",
  "316": "کهنوج",
  "535": "کوهبنان",
  "318": "گلباف",
  "607": "ماهان",
  "608": "منوجان",
  "508": "آبیک",
  "538": "آوج",
  "728": "البرز",
  "509": "بوئین زهرا",
  "438": "تاکستان",
  "439": "تاکستان",
  "580": "رودبار الموت",
  "590": "رودبار شهرستان",
  "559": "ضیاءآباد",
  "588": "طارم سفلی",
  "431": "قزوین",
  "432": "قزوین",
  "037": "قم",
  "038": "قم",
  "702": "کهک",
  "240": "آباده",
  "241": "آباده",
  "670": "آباده طشک",
  "648": "ارسنجان",
  "252": "استهبان",
  "678": "اشکنان",
  "253": "سپیدان",
  "649": "اوز",
  "513": "بوانات",
  "546": "بیضا",
  "671": "جویم",
  "246": "جهرم",
  "247": "جهرم",
  "654": "حاجی آباد(زرین دشت)",
  "548": "خرامه",
  "547": "خشت و کمارج",
  "655": "خفر",
  "248": "داراب",
  "249": "داراب",
  "514": "سروستان",
  "665": "سعادت آباد",
  "673": "شیبکوه",
  "228": "شیراز",
  "229": "شیراز",
  "230": "شیراز",
  "679": "فراشبند",
  "256": "فسا",
  "257": "فسا",
  "244": "فیروزآباد",
  "245": "فیروزآباد",
  "681": "قنقری(خرم بید)",
  "723": "قیروکارزین",
  "236": "کازرون",
  "237": "کازرون",
  "683": "کوار",
  "656": "کراش",
  "250": "لارستان",
  "251": "لارستان",
  "515": "لامرد",
  "242": "مرودشت",
  "243": "مرودشت",
  "238": "ممسنی",
  "239": "ممسنی",
  "657": "مهر",
  "255": "نی ریز",
  "684": "ایوانکی",
  "700": "بسطام",
  "642": "بیارجمند",
  "457": "دامغان",
  "456": "سمنان",
  "458": "شاهرود",
  "459": "شاهرود",
  "460": "گرمسار",
  "530": "مهدیشهر",
  "520": "میامی",
  "358": "ایرانشهر",
  "359": "ایرانشهر",
  "682": "بزمان",
  "703": "بمپور",
  "364": "چابهار",
  "365": "چابهار",
  "371": "خاش",
  "701": "دشتیاری",
  "720": "راسک",
  "366": "زابل",
  "367": "زابل",
  "704": "زابلی",
  "361": "زاهدان",
  "362": "زاهدان",
  "369": "سراوان",
  "370": "سراوان",
  "635": "فاروج",
  "668": "سیب و سوران",
  "533": "شهرکی و ناروئی(زهک)",
  "705": "شیب آب",
  "699": "فنوج",
  "669": "قصرقند",
  "725": "کنارک",
  "597": "لاشار(اسپکه)",
  "611": "میرجاوه",
  "525": "نیک شهر",
  "181": "آبادان",
  "527": "آغاجاری",
  "585": "اروندکنار",
  "685": "امیدیه",
  "663": "اندیکا",
  "192": "اندیمشک",
  "193": "اندیمشک",
  "174": "اهواز",
  "175": "اهواز",
  "183": "ایذه",
  "184": "ایذه",
  "194": "بندرماهشهر",
  "195": "بندرماهشهر",
  "185": "بهبهان",
  "186": "بهبهان",
  "199": "دزفول",
  "200": "دزفول",
  "190": "رامهرمز",
  "191": "رامهرمز",
  "187": "شوشتر",
  "188": "شوشتر",
  "196": "مسجدسلیمان",
  "197": "مسجدسلیمان",
  "072": "تربت جام",
  "073": "تربت جام",
  "069": "تربت حیدریه",
  "070": "تربت حیدریه",
  "481": "باغ ملک",
  "706": "بندر امام خمینی",
  "182": "خرمشهر",
  "198": "دشت آزادگان",
  "662": "رامشیر",
  "692": "سردشت",
  "189": "شادگان",
  "707": "شاوور",
  "526": "شوش",
  "729": "گتوند",
  "730": "لالی",
  "661": "هندیجان",
  "680": "هویزه",
  "643": "احمدآباد",
  "562": "بجستان",
  "572": "بردسکن",
  "074": "تایباد",
  "644": "تخت جلگه",
  "521": "جغتای",
  "573": "جوین",
  "522": "چناران",
  "724": "خلیل آباد",
  "076": "خواف",
  "077": "درگز",
  "650": "رشتخوار",
  "574": "زبرخان",
  "078": "سبزوار",
  "079": "سبزوار",
  "081": "سرخس",
  "084": "فریمان",
  "651": "فیض آباد",
  "086": "قوچان",
  "087": "قوچان",
  "089": "کاشمر",
  "090": "کاشمر",
  "092": "مشهد",
  "093": "مشهد",
  "094": "مشهد",
  "098": "مشهد منطقه 2",
  "097": "مشهد منطقه 3",
  "096": "مشهد منطقه 1",
  "105": "نیشابور",
  "106": "نیشابور",
  "553": "کلات",
  "091": "گناباد",
  "063": "اسفراین",
  "067": "بجنورد",
  "068": "بجنورد",
  "075": "جاجرم",
  "591": "رازوجرکلان",
  "082": "شیروان",
  "524": "مانه و سملقان",
  "468": "اردل",
  "465": "بروجن",
  "461": "شهرکرد",
  "462": "شهرکرد",
  "467": "فارسان",
  "632": "فلارد",
  "555": "کوهرنگ",
  "633": "کیار",
  "629": "گندمان",
  "466": "لردگان",
  "696": "میانکوه",
  "721": "بشرویه",
  "064": "بیرجند",
  "065": "بیرجند",
  "523": "درمیان",
  "652": "زیرکوه",
  "719": "سرایان",
  "716": "سربیشه",
  "085": "فردوس",
  "088": "قائنات",
  "563": "نهبندان",
  "529": "بندر دیلم",
  "353": "بندر گناوه",
  "349": "بوشهر",
  "350": "بوشهر",
  "355": "تنگستان",
  "609": "جم",
  "351": "دشتستان",
  "352": "دشتستان",
  "354": "دشتی",
  "732": "دلوار",
  "357": "دیر",
  "532": "سعد آباد",
  "610": "شبانکاره",
  "356": "کنگان",
  "556": "اسلامشهر",
  "658": "پاکدشت",
  "001": "تهران مرکزی",
  "002": "تهران مرکزی",
  "003": "تهران مرکزی",
  "004": "تهران مرکزی",
  "005": "تهران مرکزی",
  "006": "تهران مرکزی",
  "007": "تهران مرکزی",
  "008": "تهران مرکزی",
  "011": "تهران جنوب",
  "020": "تهران شرق",
  "025": "تهرانشمال",
  "015": "تهران غرب",
  "043": "دماوند",
  "666": "رباط کریم",
  "489": "ساوجبلاغ",
  "044": "شمیران",
  "045": "شمیران",
  "048": "شهرری",
  "049": "شهرری",
  "490": "شهریار",
  "491": "شهریار",
  "695": "طالقان",
  "659": "فیروزکوه",
  "031": "کرج",
  "032": "کرج",
  "041": "ورامین",
  "042": "ورامین",
  "664": "کهریزک",
  "717": "نظرآباد",
  "471": "امور خارجه",
  "472": "امور خارجه",
  "454": "آبدانان",
  "581": "ارکوازی(ملکشاهی)",
  "616": "ایوان",
  "449": "ایلام",
  "450": "ایلام",
  "534": "بدره",
  "455": "دره شهر",
  "451": "دهلران",
  "726": "زرین آباد",
  "634": "شیروان لومار",
  "453": "شیروان و چرداول",
  "727": "موسیان",
  "452": "مهران",
  "145": "اردبیل",
  "146": "اردبیل",
  "731": "ارشق",
  "690": "انگوت",
  "601": "بیله سوار",
  "504": "پارس آباد",
  "163": "خلخال",
  "714": "خورش رستم",
  "715": "سرعین",
  "566": "سنجبد(کوثر)",
  "166": "مشکین شهر",
  "167": "مشکین شهر",
  "161": "مغان",
  "162": "مغان",
  "686": "نمین",
  "603": "نیر",
  "619": "آران و بیدگل",
  "118": "اردستان",
  "127": "اصفهان",
  "128": "اصفهان",
  "129": "اصفهان",
  "620": "باغ بهادران",
  "621": "بوئین و میاندشت",
  "549": "تیران و کرون",
  "564": "جرقویه",
  "575": "چادگان",
  "113": "خمینی شهر",
  "114": "خمینی شهر",
  "122": "خوانسار",
  "540": "خور و بیابانک",
  "660": "دولت آباد",
  "120": "سمیرم",
  "512": "سمیرم سفلی (دهاقان)",
  "510": "شاهین شهر",
  "511": "شاهین شهر",
  "119": "شهرضا",
  "115": "فریدن",
  "112": "فریدونشهر",
  "110": "فلاورجان",
  "111": "فلاورجان",
  "125": "کاشان",
  "126": "کاشان",
  "565": "کوهپایه",
  "121": "گلپایگان",
  "116": "لنجان(زرینشهر)",
  "117": "لنجان(زرینشهر)",
  "541": "مبارکه",
  "622": "میمه",
  "124": "نائین",
  "108": "نجف آباد",
  "109": "نجف آباد",
  "427": "زنجان",
  "428": "زنجان",
  "507": "ملکان",
  "158": "مرند",
  "615": "ابهر و خرمدره",
  "152": "میانه",
  "153": "میانه",
  "123": "نطنز"
};
