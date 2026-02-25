import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../product/data/models/product_model.dart';
import '../../data/models/cart_item_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartLoaded([]));

  void addToCart(ProductModel product) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final items = List<CartItemModel>.from(currentState.items);

      final existingIndex = items.indexWhere((item)
        => item.product.id == product.id);
      
      if (existingIndex >= 0) {
        items[existingIndex] = items[existingIndex].copyWith(
          quantity: items[existingIndex].quantity + 1,
        );
      } else {
        items.add(CartItemModel(product: product));
      }
      emit(CartLoaded(items));
    }
  }

  void removeFromCart(int productId) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedItems = currentState.items
          .where((item) => item.product.id != productId)
          .toList();
      emit(CartLoaded(updatedItems));
    }
  }

  void decrementQuantity(int productId) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final items = List<CartItemModel>.from(currentState.items);

      final existingIndex = items.indexWhere((item) => item.product.id == productId);

      if (existingIndex >= 0) {
        final currentItem = items[existingIndex];
        if (currentItem.quantity > 1) {
          items[existingIndex] = currentItem.copyWith(
            quantity: currentItem.quantity - 1,
          );
        } else {
          items.removeAt(existingIndex);
        }
        emit(CartLoaded(items));
      }
    }
  }

  void clearCart() {
    emit(CartLoaded([]));
  }
}
