import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../domain/bloc/product_bloc.dart';
import '../../domain/bloc/product_event.dart';
import '../../domain/bloc/product_state.dart';
import '../../../cart/domain/cubit/cart_cubit.dart';
import '../../../cart/presentation/pages/cart_pages.dart';
// Import widget yang baru saja kita buat
import '../../../../shared/widget/search_bar.dart' as custom_search;
import '../../../../shared/widget/category_item.dart';
import '../../../../shared/widget/product_card.dart';

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

  void _showErrorSnackbar(String message) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Error',
        message: message,
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Warna background kebiruan mirip desain
      body: SafeArea(
        child: BlocConsumer<ProductBloc, ProductState>(
          bloc: productBloc,
          listener: (context, state) {
            if (state is ProductError) {
              _showErrorSnackbar(state.message);
            }
          },
          builder: (context, state) {
            // Kita akan selalu menampilkan header & kategori meskipun sedang loading
            return CustomScrollView(
              slivers: [
                // 1. Header Section (Logo, Search Bar, Cart)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.grid_view_rounded),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: BlocBuilder<CartCubit, CartState>(
                                bloc: Modular.get<CartCubit>(),
                                builder: (context, state) {
                                  int totalPcs = 0;
                                  if (state is CartLoaded) {
                                    totalPcs = state.totalItems;
                                  }
                                  return GestureDetector(
                                    onTap: () => Modular.to.pushNamed('/cart'),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        const Icon(Icons.shopping_cart_outlined),
                                        if (totalPcs > 0)
                                          Positioned(
                                            right: -4,
                                            top: -4,
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(
                                                totalPcs > 99 ? '99+' : totalPcs.toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Search Bar buatan kita
                        const custom_search.SearchBar(),
                      ],
                    ),
                  ),
                ),

                // 2. Categories Section
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Grid statis untuk ikon kategori
                        GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 1.1,
                          children: [
                            CategoryItem(iconData: Icons.phone_iphone, title: 'Mobile', onTap: () {}),
                            CategoryItem(iconData: Icons.headphones, title: 'Headphone', onTap: () {}),
                            CategoryItem(iconData: Icons.tablet_mac, title: 'Tablets', onTap: () {}),
                            CategoryItem(iconData: Icons.laptop_mac, title: 'Laptop', onTap: () {}),
                            CategoryItem(iconData: Icons.speaker, title: 'Speakers', onTap: () {}),
                            CategoryItem(iconData: Icons.apps, title: 'More', isSelected: true, onTap: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // 3. Flash Deals Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Flash Deals for You',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('See All', style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ),
                ),

                // 4. Products Grid Section
                if (state is ProductLoading)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Center(
                        child: SpinKitChasingDots(color: Colors.black, size: 50),
                      ),
                    ),
                  )
                else if (state is ProductError)
                  SliverToBoxAdapter(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.message, textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => productBloc.add(LoadProducts()),
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (state is ProductLoaded)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75, // Mengatur tinggi tiap kotak
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ProductCard(product: state.products[index]);
                        },
                        childCount: state.products.length,
                      ),
                    ),
                  ),

                // Spacing ekstra di bawah
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            );
          },
        ),
      ),
    );
  }
}
