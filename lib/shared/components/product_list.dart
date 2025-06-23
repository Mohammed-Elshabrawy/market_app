import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/shared/components/product_card.dart';
import '../../models/product_model.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, this.shrinkWrap, this.physics});
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getProducts(),
      child: BlocConsumer<HomeCubit, HomeStates>(

        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          List<ProductModel> products = HomeCubit.get(context).products;
          return state is GetDataLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: shrinkWrap ?? true,
                  physics: physics ?? NeverScrollableScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ProductCard(),
                  ),
                );
        },
      ),
    );
  }
}
