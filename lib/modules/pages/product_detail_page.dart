import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class ProductDetailPage extends StatefulWidget {
    final String id;ProductDetailPage({super.key, required this.id});
    

    @override
State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
    final ProductBloc productBloc = Modular.get<ProductBloc>();
    @override
    void initState() {
        super.initState();
        productBloc.add(LoadProductDetail(id: int.parse(widget.id)));
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: BlocBuilder<ProductBloc, ProductState>(
                //memanggil bloc
                bloc: productBloc, builder: (context, state) {
                    if (state is ProductLoading) {
                        return const Center(
                            child: CircularProgressIndicator()
                        );
                    }
                    else if (state is ProductDetailLoaded) {
                        final product = state.product;
                        return SingleChildScrollView(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                children: [
                                    Image.network(product.image
                                    ,height: 200,
                                    width: 200,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(product.title
                                    , style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)
                                    ),
                                    const SizedBox(height: 8),
                                    Text('\$${product.price}', style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold)
                                    ),
                                    const SizedBox(height: 16),
                                    Text(product.description),
                                ],
                            ),
                        );
                    }
                    else if (state is ProductError) {
                        return Center(child: Text(state.message));
                }
                return Container();
            },
        ),
    );
    }
}