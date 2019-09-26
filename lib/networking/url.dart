class URL {
  static const _isProd = true;
  static const _baseUrl = _isProd
      ? 'https://private-f5e97-myunitconverter.apiary-mock.com'
      : 'https://private-0dbf1f-myunitconverterstg.apiary-mock.com';

  static String _pairBase(String url) {
    return _baseUrl + url;
  }

  static final backdropList = _pairBase('/backdropList');
  static final conversions = _pairBase('/fake/conversions');
}
