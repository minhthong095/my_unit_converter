class URL {
  static const _isProd = true;
  static const _baseUrl = _isProd
      ? 'https://private-f5e97-myunitconverter.apiary-mock.com/'
      : 'https://private-0dbf1f-myunitconverterstg.apiary-mock.com/';

  static const backdropList = _baseUrl + 'backdropList';
}
