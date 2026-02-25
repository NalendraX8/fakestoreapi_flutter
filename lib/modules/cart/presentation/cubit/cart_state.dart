part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
    final List<CartItemModel> items;
    CartLoaded(this.items);

    //ini untuk hitung total
    int get totalItems {
        return items.fold(0, (total, current)
        => total + current.quantity);
    }

    double get totalPrice {
        return items.fold(0.0, (total, current)
         => total + (current.product.price * current.quantity)
        );
    }
}

class CartError extends CartState {
    final String message;
    CartError(this.message);
}