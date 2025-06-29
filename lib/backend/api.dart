class Api {
  static const String _baseUrl = 'https://api.escuelajs.co/api/v1/';

  //services

  // Auth
  static const String createUser = '${_baseUrl}users/';
  static const String login = '${_baseUrl}auth/login';

  //Products
  static const String products = '${_baseUrl}products';

  //Categories
  static const String categories = '${_baseUrl}categories';
}
