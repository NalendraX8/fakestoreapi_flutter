import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fast_store/modules/bloc/product_bloc.dart';
import 'package:fast_store/modules/bloc/product_event.dart';
import 'package:fast_store/modules/bloc/product_state.dart';

class ProductListPage extends StatefulWidget {
    const ProductListPage({super.key});

    @override
    State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
    final ProductBloc productBloc = Modular.get<ProductBloc>(); 
    @override
    void initState() {
        super.initState();
        productBloc.add(LoadProducts());
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: BlocBuilder<ProductBloc, ProductState>(
                bloc: productBloc,
                builder: (context, state) {
                    if (state is ProductLoading) {
                        return const Center(
                            //loading pake circularprogress
                            child: CircularProgressIndicator()
                        );
                    } else if (state is ProductLoaded) {
                        return ListView.builder(
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                                final product = state.products[index];
                                return Card(
                                    margin: const EdgeInsets.all(8),
                                    child: ListTile(
                                        leading: Image.network(product.image, width: 50),

                                        title: Text(product.title),
                                        subtitle: Text('\$${product.price}'),
                                        trailing: Icon(Icons.arrow_forward),
                                        onTap: () {
                                            //navigasi ke detail produk dan bisa bolak balik
                                            Modular.to.pushNamed('/product/${product.id}');
                                        },
                                    ),
                                );
                            },
                        );
                } else if (state is ProductError) {
                    return Center(
                        child: Text(state.message)
                    );
                }
                return Container();
            },
        ),
        );
    }
}
