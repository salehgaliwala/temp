class ConfigModel {
  int _systemDefaultCurrency;
  bool _digitalPayment;
  bool _cod;
  BaseUrls _baseUrls;
  StaticUrls _staticUrls;
  String _aboutUs;
  String _privacyPolicy;
  List<Faq> _faq;
  String _termsConditions;
  List<CurrencyList> _currencyList;
  String _currencySymbolPosition;
  bool _maintenanceMode;
  List<String> _language;
  List<Colors> _colors;
  List<String> _unit;
  String _shippingMethod;
  String _currencyModel;
  bool _emailVerification;
  bool _phoneVerification;
  String _countryCode;
  List<SocialLogin> _socialLogin;
  String _forgetPasswordVerification;
  Announcement _announcement;

  ConfigModel(
      {int systemDefaultCurrency,
        bool digitalPayment,
        bool cod,
        BaseUrls baseUrls,
        StaticUrls staticUrls,
        String aboutUs,
        String privacyPolicy,
        List<Faq> faq,
        String termsConditions,
        List<CurrencyList> currencyList,
        String currencySymbolPosition,
        bool maintenanceMode,
        List<String> language,
        List<Colors> colors,
        List<String> unit,
        String shippingMethod,
        String currencyModel,
        bool emailVerification,
        bool phoneVerification,
        String countryCode,
        List<SocialLogin> socialLogin,
        String forgetPasswordVerification,
        Announcement announcement,


      }) {
    this._systemDefaultCurrency = systemDefaultCurrency;
    this._digitalPayment = digitalPayment;
    this._cod = cod;
    this._baseUrls = baseUrls;
    this._staticUrls = staticUrls;
    this._aboutUs = aboutUs;
    this._privacyPolicy = privacyPolicy;
    this._faq = faq;
    this._termsConditions = termsConditions;
    this._currencyList = currencyList;
    this._currencySymbolPosition = currencySymbolPosition;
    this._maintenanceMode = maintenanceMode;
    this._language = language;
    this._colors = colors;
    this._unit = unit;
    this._shippingMethod = shippingMethod;
    this._currencyModel = currencyModel;
    this._emailVerification = emailVerification;
    this._phoneVerification = phoneVerification;
    this._countryCode = countryCode;
    this._socialLogin = socialLogin;
    this._forgetPasswordVerification = forgetPasswordVerification;
    this._announcement = announcement;
  }

  int get systemDefaultCurrency => _systemDefaultCurrency;
  bool get digitalPayment => _digitalPayment;
  bool get cod => _cod;
  BaseUrls get baseUrls => _baseUrls;
  StaticUrls get staticUrls => _staticUrls;
  String get aboutUs => _aboutUs;
  String get privacyPolicy => _privacyPolicy;
  List<Faq> get faq => _faq;
  String get termsConditions => _termsConditions;
  List<CurrencyList> get currencyList => _currencyList;
  String get currencySymbolPosition => _currencySymbolPosition;
  bool get maintenanceMode => _maintenanceMode;
  List<String> get language => _language;
  List<Colors> get colors => _colors;
  List<String> get unit => _unit;
  String get shippingMethod => _shippingMethod;
  String get currencyModel => _currencyModel;
  bool get emailVerification => _emailVerification;
  bool get phoneVerification => _phoneVerification;
  String get countryCode =>_countryCode;
  List<SocialLogin> get socialLogin => _socialLogin;
  String get forgetPasswordVerification => _forgetPasswordVerification;
  Announcement get announcement => _announcement;

  ConfigModel.fromJson(Map<String, dynamic> json) {
    _systemDefaultCurrency = json['system_default_currency'];
    _digitalPayment = json['digital_payment'];
    _cod = json['cash_on_delivery'];
    _baseUrls = json['base_urls'] != null
        ? new BaseUrls.fromJson(json['base_urls'])
        : null;
    _staticUrls = json['static_urls'] != null
        ? new StaticUrls.fromJson(json['static_urls'])
        : null;
    _aboutUs = json['about_us'];
    _privacyPolicy = json['privacy_policy'];
   if (json['faq'] != null) {
      _faq = [];
      json['faq'].forEach((v) {_faq.add(new Faq.fromJson(v));
      });
    }
    _termsConditions = json['terms_&_conditions'];
    if (json['currency_list'] != null) {
      _currencyList = [];
      json['currency_list'].forEach((v) {_currencyList.add(new CurrencyList.fromJson(v));
      });
    }
    _currencySymbolPosition = json['currency_symbol_position'];
    _maintenanceMode = json['maintenance_mode'];
    _language = json['language'].cast<String>();
    if (json['colors'] != null) {
      _colors = [];
      json['colors'].forEach((v) {_colors.add(new Colors.fromJson(v));
      });
    }

    _unit = json['unit'].cast<String>();
    _shippingMethod = json['shipping_method'];
    _currencyModel = json['currency_model'];
    _emailVerification = json['email_verification'];
    _phoneVerification = json['phone_verification'];
    _countryCode = json['country_code'];
    if (json['social_login'] != null) {
      _socialLogin = [];
      json['social_login'].forEach((v) { _socialLogin.add(new SocialLogin.fromJson(v)); });
    }
    _forgetPasswordVerification = json['forgot_password_verification'];
    _announcement = json['announcement'] != null
        ? new Announcement.fromJson(json['announcement'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['system_default_currency'] = this._systemDefaultCurrency;
    data['digital_payment'] = this._digitalPayment;
    data['cash_on_delivery'] = this._cod;
    if (this._baseUrls != null) {
      data['base_urls'] = this._baseUrls.toJson();
    }
    if (this._staticUrls != null) {
      data['static_urls'] = this._staticUrls.toJson();
    }
    data['about_us'] = this._aboutUs;
    data['privacy_policy'] = this._privacyPolicy;
    if (this._faq != null) {
      data['faq'] = this._faq.map((v) => v.toJson()).toList();
    }
    data['terms_&_conditions'] = this._termsConditions;
    if (this._currencyList != null) {
      data['currency_list'] =
          this._currencyList.map((v) => v.toJson()).toList();
    }
    data['currency_symbol_position'] = this._currencySymbolPosition;
    data['maintenance_mode'] = this._maintenanceMode;
    data['language'] = this._language;
    if (this._colors != null) {
      data['colors'] = this._colors.map((v) => v.toJson()).toList();
    }
    data['unit'] = this._unit;
    data['shipping_method'] = this._shippingMethod;
    data['currency_model'] = this._currencyModel;
    data['email_verification'] = this._emailVerification;
    data['phone_verification'] = this._phoneVerification;
    data['country_code'] = this._countryCode;
    if (this._socialLogin != null) {
      data['social_login'] = this._socialLogin.map((v) => v.toJson()).toList();
    }
    data['forgot_password_verification'] = this._forgetPasswordVerification;
    if (this._announcement != null) {
      data['announcement'] = this._announcement.toJson();
    }

    return data;
  }
}

class BaseUrls {
  String _productImageUrl;
  String _productThumbnailUrl;
  String _brandImageUrl;
  String _customerImageUrl;
  String _bannerImageUrl;
  String _categoryImageUrl;
  String _reviewImageUrl;
  String _sellerImageUrl;
  String _shopImageUrl;
  String _notificationImageUrl;

  BaseUrls(
      {String productImageUrl,
        String productThumbnailUrl,
        String brandImageUrl,
        String customerImageUrl,
        String bannerImageUrl,
        String categoryImageUrl,
        String reviewImageUrl,
        String sellerImageUrl,
        String shopImageUrl,
        String notificationImageUrl}) {
    this._productImageUrl = productImageUrl;
    this._productThumbnailUrl = productThumbnailUrl;
    this._brandImageUrl = brandImageUrl;
    this._customerImageUrl = customerImageUrl;
    this._bannerImageUrl = bannerImageUrl;
    this._categoryImageUrl = categoryImageUrl;
    this._reviewImageUrl = reviewImageUrl;
    this._sellerImageUrl = sellerImageUrl;
    this._shopImageUrl = shopImageUrl;
    this._notificationImageUrl = notificationImageUrl;
  }

  String get productImageUrl => _productImageUrl;
  String get productThumbnailUrl => _productThumbnailUrl;
  String get brandImageUrl => _brandImageUrl;
  String get customerImageUrl => _customerImageUrl;
  String get bannerImageUrl => _bannerImageUrl;
  String get categoryImageUrl => _categoryImageUrl;
  String get reviewImageUrl => _reviewImageUrl;
  String get sellerImageUrl => _sellerImageUrl;
  String get shopImageUrl => _shopImageUrl;
  String get notificationImageUrl => _notificationImageUrl;


  BaseUrls.fromJson(Map<String, dynamic> json) {
    _productImageUrl = json['product_image_url'];
    _productThumbnailUrl = json['product_thumbnail_url'];
    _brandImageUrl = json['brand_image_url'];
    _customerImageUrl = json['customer_image_url'];
    _bannerImageUrl = json['banner_image_url'];
    _categoryImageUrl = json['category_image_url'];
    _reviewImageUrl = json['review_image_url'];
    _sellerImageUrl = json['seller_image_url'];
    _shopImageUrl = json['shop_image_url'];
    _notificationImageUrl = json['notification_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_image_url'] = this._productImageUrl;
    data['product_thumbnail_url'] = this._productThumbnailUrl;
    data['brand_image_url'] = this._brandImageUrl;
    data['customer_image_url'] = this._customerImageUrl;
    data['banner_image_url'] = this._bannerImageUrl;
    data['category_image_url'] = this._categoryImageUrl;
    data['review_image_url'] = this._reviewImageUrl;
    data['seller_image_url'] = this._sellerImageUrl;
    data['shop_image_url'] = this._shopImageUrl;
    data['notification_image_url'] = this._notificationImageUrl;
    return data;
  }
}

class StaticUrls {
  String _contactUs;
  String _brands;
  String _categories;
  String _customerAccount;

  StaticUrls(
      {String contactUs,
        String brands,
        String categories,
        String customerAccount}) {
    this._contactUs = contactUs;
    this._brands = brands;
    this._categories = categories;
    this._customerAccount = customerAccount;
  }

  String get contactUs => _contactUs;
  String get brands => _brands;
  String get categories => _categories;
  String get customerAccount => _customerAccount;


  StaticUrls.fromJson(Map<String, dynamic> json) {
    _contactUs = json['contact_us'];
    _brands = json['brands'];
    _categories = json['categories'];
    _customerAccount = json['customer_account'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_us'] = this._contactUs;
    data['brands'] = this._brands;
    data['categories'] = this._categories;
    data['customer_account'] = this._customerAccount;
    return data;
  }
}

class SocialLogin {
  String _loginMedium;
  bool _status;

  SocialLogin({String loginMedium, bool status}) {
    this._loginMedium = loginMedium;
    this._status = status;
  }

  String get loginMedium => _loginMedium;
  bool get status => _status;

  SocialLogin.fromJson(Map<String, dynamic> json) {
    _loginMedium = json['login_medium'];
    _status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_medium'] = this._loginMedium;
    data['status'] = this._status;
    return data;
  }
}

class Faq {
  int _id;
  String _question;
  String _answer;
  int _ranking;
  int _status;
  String _createdAt;
  String _updatedAt;

  Faq(
      {int id,
        String question,
        String answer,
        int ranking,
        int status,
        String createdAt,
        String updatedAt}) {
    this._id = id;
    this._question = question;
    this._answer = answer;
    this._ranking = ranking;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  String get question => _question;
  String get answer => _answer;
  int get ranking => _ranking;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;


  Faq.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _question = json['question'];
    _answer = json['answer'];
    _ranking = json['ranking'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['question'] = this._question;
    data['answer'] = this._answer;
    data['ranking'] = this._ranking;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

class CurrencyList {
  int _id;
  String _name;
  String _symbol;
  String _code;
  double _exchangeRate;
  int _status;
  String _createdAt;
  String _updatedAt;

  CurrencyList(
      {int id,
        String name,
        String symbol,
        String code,
        double exchangeRate,
        int status,
        String createdAt,
        String updatedAt}) {
    this._id = id;
    this._name = name;
    this._symbol = symbol;
    this._code = code;
    this._exchangeRate = exchangeRate;
    this._status = status;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  String get name => _name;
  String get symbol => _symbol;
  String get code => _code;
  double get exchangeRate => _exchangeRate;
  int get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;


  CurrencyList.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _symbol = json['symbol'];
    _code = json['code'];
    _exchangeRate = json['exchange_rate'].toDouble();
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['symbol'] = this._symbol;
    data['code'] = this._code;
    data['exchange_rate'] = this._exchangeRate;
    data['status'] = this._status;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

class Colors {
  int _id;
  String _name;
  String _code;
  String _createdAt;
  String _updatedAt;

  Colors(
      {int id, String name, String code, String createdAt, String updatedAt}) {
    this._id = id;
    this._name = name;
    this._code = code;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  int get id => _id;
  String get name => _name;
  String get code => _code;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;


  Colors.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _code = json['code'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['code'] = this._code;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
class Announcement {
  String _status;
  String _color;
  String _textColor;
  String _announcement;

  Announcement({String status, String color,String textColor, String announcement}) {
    if (status != null) {
      this._status = status;
    }
    if (color != null) {
      this._color = color;
    }
    if (textColor != null) {
      this._textColor = textColor;
    }
    if (announcement != null) {
      this._announcement = announcement;
    }
  }

  String get status => _status;
  String get color => _color;
  String get textColor => _textColor;
  String get announcement => _announcement;
  Announcement.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _color = json['color'];
    _textColor = json['text_color'];
    _announcement = json['announcement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['color'] = this._color;
    data['text_color'] = this._textColor;
    data['announcement'] = this._announcement;
    return data;
  }
}
