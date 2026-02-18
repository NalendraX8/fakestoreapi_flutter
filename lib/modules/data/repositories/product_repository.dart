import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductRepository {

    //networking pakai dio inject lewat constructor
    final Dio dio;
    ProductRepository({required this.dio});

    Future<List<ProductModel>> getProducts() async {
        try{
            //get produk dari fakestoreapi
            final response = await dio.get('https://fakestoreapi.com/products');

            if (response.statusCode == 200) {
                final List<dynamic> data = response.data;
                return data.map((e) => ProductModel.fromJson((e))).toList();
            } else {
                throw Exception('gagal mengambil data hayo');
            }
        } catch (e) {
            throw Exception('Error: $e');
        }
    }
    //ini menuju ke detail produk
    Future<ProductModel> getProductById(int id) async {
        try {
            final response = await dio.get('https://fakestoreapi.com/products/$id');
            if (response.statusCode == 200) {
                return ProductModel.fromJson(response.data);
            } else {
                throw Exception('produk ngilang');
            }
        } catch (e) {
            throw Exception('Error: $e');
        }
    }
}