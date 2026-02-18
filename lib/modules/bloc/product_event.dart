abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class LoadProductDetail extends ProductEvent {
    final int id;
    LoadProductDetail({required this.id});
}
    