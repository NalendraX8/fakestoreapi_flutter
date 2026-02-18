import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../modules/pages/product_list_page.dart';
import '../modules/pages/product_detail_page.dart';
import '../modules/bloc/product_bloc.dart';
import '../modules/data/repositories/product_repository.dart';

class AppModule extends Module {
    @override
    void binds(Injector i) {
        //bind dio networking cik
        i.addSingleton<Dio>(() => Dio());
        //bind repo, dio auto inject ke repo
        i.add(() => ProductRepository(dio: i<Dio>()));
        //bind bloc
        i.add(() => ProductBloc(repository: i<ProductRepository>()));
    }

  @override
  void routes(r) {
    // Route Awal (List Produk)
    r.child('/', child: (context) => const ProductListPage());
    // Route Detail (dengan parameter :id)
    r.child('/product/:id', child: (context) => ProductDetailPage(id: r.args.params['id']));
    }
}
