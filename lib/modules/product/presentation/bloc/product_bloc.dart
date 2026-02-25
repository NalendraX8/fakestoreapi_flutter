import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    
    // Handler untuk mengambil semua produk
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await repository.getProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString().replaceAll('Exception: ', '')));
      }
    });

    // Handler untuk mengambil detail produk
    on<LoadProductDetail>((event, emit) async {
      emit(ProductLoading());
      try {
        final product = await repository.getProductById(event.id);
        emit(ProductDetailLoaded(product));
      } catch (e) {
        emit(ProductError(e.toString().replaceAll('Exception: ', '')));
      }
    });
  }
}
