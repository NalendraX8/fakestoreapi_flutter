//reminder
//bloc = business logic component
//state = status
//event = trigger

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
    final ProductRepository repository;

    ProductBloc({
        required this.repository
    }) : 
    super(ProductInitial()) {
        on<LoadProducts>((event, emit) async {
            emit(ProductLoading());
            try {
                //ngambil data dari repo
                final products = await repository.getProducts();
                emit(ProductLoaded(products));
            } catch (e) {
                emit(ProductError(e.toString()));
            }
        },
        );
        on<LoadProductDetail>((event, emit) async {
            emit(ProductLoading());
            try {
                final product = await repository.getProductById(event.id);
                emit(ProductDetailLoaded(product));
            } catch (e) {
                emit(ProductError(e.toString()));
            }
        },
        );
    }
}
