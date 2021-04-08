import 'package:pagination_example/common/configs.dart';
import 'package:pagination_example/data/repo.dart';
import 'package:pagination_example/model/app/singleton_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

final _repo = new Repo();
String _token;

class Request {
  _ModulA modulA = _ModulA();
  _ModulB modulB = _ModulB();

  Request() {
    _token = (SingletonModel.shared.isLoggedIn ?? false)
        ? "Bearer ${SingletonModel.shared.user.token}"
        : "";
  }

  Future<http.Response> noContext() {
    return _repo.noContext();
  }
}

class _ModulA {
  Future<http.Response> stringBuilder({@required String nomer}) {
    return _repo.modulA.stringBuilder(nomer: nomer);
  }

  Future<http.Response> endpoint() {
    return _repo.modulA.endpoint(header: kDHeader(token: _token));
  }
}

class _ModulB {
  _SubAModulB subAModulB = _SubAModulB();

  Future<dio.Response> tes() {
    return _repo.modulB.tes();
  }
}

class _SubAModulB {
  Future<http.Response> check({
    @required String nama,
    @required String email,
  }) {
    return _repo.modulB.subAModulB.tes(data: {
      "nama": "$nama",
      "email": "$email",
    });
  }
}
