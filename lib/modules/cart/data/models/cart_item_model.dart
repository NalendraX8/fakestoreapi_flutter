import 'package:json_annotation/json_annotation.dart';
import '../../../product/data/models/product_model.dart';
part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
    final ProductModel product;
    final int quantity;

    CartItemModel({
        required this.product,
        this.quantity = 1, //default 1
    });

    CartItemModel copyWith({
        ProductModel? product,
        int? quantity,
    }) {
        return CartItemModel(
            product: product ?? this.product,
            quantity: quantity ?? this.quantity,
        );
    }

    //ini untuk hitung subtotal
    double get subTotal => product.price * quantity;

    factory CartItemModel.fromJson(Map<String, dynamic> json) 
        => _$CartItemModelFromJson(json);
    
    Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}