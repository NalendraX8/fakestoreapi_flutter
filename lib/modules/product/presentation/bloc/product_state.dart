import '../../data/models/product_model.dart';

abstract class ProductState {}

    //class kaga ngapa ngapain
    class ProductInitial extends ProductState {}
    //class nge load alias fetch api
    class ProductLoading extends ProductState {}
    //class sukses load api
    class ProductLoaded extends ProductState {
        final List<ProductModel> products;
        ProductLoaded(this.products);
    }

    class ProductDetailLoaded extends ProductState {
        final ProductModel product;
        ProductDetailLoaded(this.product);
    }
    
    class ProductError extends ProductState {
        final String message;
        ProductError(this.message);
    }
