import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:nike_store/src/core/network/api_provider/api_provider.dart';

abstract class BaseApi {
  @protected
  final baseApi = KiwiContainer().resolve<ApiProvider>();
}
