final String _baseUrl = "https://domain.com/api/v1/";

class API {
  _ModulA modulA = _ModulA();
  _ModulB modulB = _ModulB();

  final String baseUrl = "https://domain.com/api/v1/";
  final String noContext = "${_baseUrl}tes";
}

class _ModulA {
  final String tes = "${_baseUrl}tes";
  final String endpoint = "${_baseUrl}endpoint";

  String stringBuilder(String embed) => "${_baseUrl}string/$embed/builder";
}

class _ModulB {
  _SubAModulB subAModulB = _SubAModulB();
  final String tes = "${_baseUrl}tes";
}

class _SubAModulB {
  final String tes = "${_baseUrl}tes";
}
