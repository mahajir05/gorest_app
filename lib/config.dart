// ignore_for_file: constant_identifier_names

class Environments {
  static const String PRODUCTION = 'prod';
  static const String QAS = 'QAS';
  static const String DEV = 'dev';
  static const String LOCAL = 'local';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.DEV;
  static final List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.LOCAL,
      'url': 'http://localhost:8080/api/',
    },
    {
      'env': Environments.DEV,
      'url': 'https://gorest.co.in',
    },
    {
      'env': Environments.QAS,
      'url': 'https://gorest.co.in',
    },
    {
      'env': Environments.PRODUCTION,
      'url': 'https://gorest.co.in',
    },
  ];

  static Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere(
      (d) => d['env'] == _currentEnvironments,
    );
  }
}
