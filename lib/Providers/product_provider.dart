import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:interview_app/core/api_Services.dart';
import 'package:interview_app/core/app_constant.dart';

class ProductProvider extends ChangeNotifier{

  List _productList = [];
  List get productList => _productList;

  bool _loading_product = false;
  bool get loading_product => _loading_product;


  List _searchList = [];
  List get searchList => _searchList;


  

  

  Future<void> getProducts()async{
    try{
      _loading_product = true;
      notifyListeners();

      var response = await ApiService.get(AppConstant.BASE_URL+AppConstant.GET_PRODUCTS);
      if (response is List) {
        _productList = response;
        print("product list -------$_productList");
      } else {
        throw Exception('Unexpected response format');
      }

    } on TimeoutException catch(e){
      throw Exception('Unexpected response format');

    } on SocketException catch(e){
     throw Exception('Unexpected response format');
    } catch (e){
     throw Exception('Unexpected response format');
    } finally{
     _loading_product = false;
     notifyListeners();
    }
  }



Future<void> searchProduct(String search) async {
  if (search.isEmpty) {
    _searchList = _productList;
  } else {
    _searchList = _productList.where((item) {
      final title = item['title']?.toString().toLowerCase() ?? '';
      return title.contains(search.toLowerCase());
    }).toList();
  }
  notifyListeners();
}


void disposeSearch()async{
  _searchList.clear();
}
}