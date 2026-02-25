import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductRepository {

    //networking pakai dio inject lewat constructor
    final Dio dio;
    ProductRepository({required this.dio});

Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get('https://fakestoreapi.com/products');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception('Gagal mengambil data produk');
      }
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    } catch (e) {
      throw Exception('Terjadi kesalahan tidak terduga');
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await dio.get('https://fakestoreapi.com/products/$id');
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw Exception('Produk tidak ditemukan');
      }
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    } catch (e) {
      throw Exception('Terjadi kesalahan');
    }
  }

    //ini untuk handle error

    String _handleError(DioException e) {
        switch (e.type) {
            case DioExceptionType.connectionTimeout:
                return 'Koneksi timeout';
            case DioExceptionType.sendTimeout:
                return 'Koneksi timeout';
            case DioExceptionType.receiveTimeout:
                return 'Koneksi lambat, coba lagi dengan koneksi yang lebih baik';
            case DioExceptionType.badResponse:
                return 'Server Error (${e.response?.statusCode}), Mohon coba kembali lagi';
            case DioExceptionType.cancel:
                return 'Permintaan dibatalkan';
            case DioExceptionType.connectionError:
                return 'aduh gak ada koneksi internet';
            default:
                return 'Terjadi gangguan pada jaringan';
        }
    }
}
