class Endpoints {
  static const String baseURL =
      "https://66038e2c2393662c31cf2e7d.mockapi.io/api/v1";

  static const String baseURLLive = "https://simobile.singapoly.com";
  static const String nim = "2215091010";

  static const String news = "$baseURL/news";
  static const String datas = "$baseURLLive/api/datas";
  // ignore: constant_identifier_names
  static const String issue = "$baseURLLive/api/customer-service/$nim";
  static const String balance = "$baseURLLive/api/balance/$nim";
  static const String spending = "$baseURLLive/api/spending/$nim";
}
