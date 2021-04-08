import 'dart:async';

import 'package:pagination_example/common/configs.dart';
import 'package:pagination_example/data/api.dart';
import 'package:pagination_example/data/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pagination_example/data/http.dart';
import 'package:dio/dio.dart' as dio;

final _api = new API();

class Repo {
  _ModulA modulA = _ModulA();
  _ModulB modulB = _ModulB();

  Future<http.Response> noContext() async {
    return await Http.get(url: _api.noContext, header: kDHeader());
  }
}

class _ModulA {
  Future<http.Response> stringBuilder({@required String nomer}) async {
    return await Http.get(
      url: _api.modulA.stringBuilder(nomer),
      header: kDHeader(),
    );
  }

  Future<http.Response> endpoint({
    @required Map<String, dynamic> header,
  }) async {
    return await Http.get(
      url: _api.modulA.endpoint,
      header: header,
    );
  }
}

class _ModulB {
  _SubAModulB subAModulB = _SubAModulB();

  Future<dio.Response> tes() async {
    return await Dio.get(url: _api.modulB.tes, header: kDHeader());
  }
}

class _SubAModulB {
  Future<http.Response> tes({@required Map<String, dynamic> data}) async {
    return await Http.post(
      url: _api.modulB.tes,
      header: kDHeader(),
      body: data,
    );
  }
}
