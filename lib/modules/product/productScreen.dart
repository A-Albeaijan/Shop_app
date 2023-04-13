import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/rewidget.dart';
import 'package:shop_app/style/them.dart';

class PrdocutScreen extends StatelessWidget {
  const PrdocutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesDataState) {
          if (state.model.status == false) {
            ShowToast(
                message: state.model.message!, ToastState: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ShopCubit.get(context).homeModel == null &&
                ShopCubit.get(context).categoriesModel == null
            ? Center(child: CircularProgressIndicator())
            : prdocutBuilder(ShopCubit.get(context).homeModel!,
                ShopCubit.get(context).categoriesModel!, context);
      },
    );
  }

  Widget prdocutBuilder(
      HomeModel model, CategoriesModel categoriesModel, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data!.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e['image']),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 250,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        buildCategoriesItem(categoriesModel.Data!.data![index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    itemCount: categoriesModel.Data!.data!.length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1 / 1.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                model.data!.products.length,
                (index) => BuildProduct(model.data!.products[index], context),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCategoriesItem(DataModel model) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 100,
            child: Text(
              model.name!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );

  Widget BuildProduct(var model, context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  height: 200,
                  image: NetworkImage(model['image']),
                  width: double.infinity,
                ),
                if (model['discount'] != 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Text(
              model['name'],
              style: const TextStyle(
                fontSize: 14,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  model['price'].toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.2,
                    color: DefaultColor,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                if (model['discount'] != 0)
                  Text(
                    model['old_price'].toString(),
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 10,
                      height: 1.2,
                      color: Colors.grey,
                    ),
                  ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context).changefavorites(model['id']);
                    print(model['id']);
                  },
                  icon: Icon(
                      color: ShopCubit.get(context).favoriteList[model['id']]!
                          ? Colors.red
                          : Colors.grey,
                      ShopCubit.get(context).favoriteList[model['id']]!
                          ? Icons.favorite
                          : Icons.favorite_outline),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
