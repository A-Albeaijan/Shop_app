import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../models/getfacoriteModel.dart';
import '../../style/them.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is ShopLoadingGetFavoriteState
            ? const Center(child: CircularProgressIndicator())
            : ShopCubit.get(context).getFavoritModel!.data!.data!.length >= 1
                ? ListView.separated(
                    itemBuilder: (context, index) => FivoriteItem(
                        ShopCubit.get(context)
                            .getFavoritModel!
                            .data!
                            .data![index]
                            .product!,
                        context),
                    separatorBuilder: (context, index) => Container(
                      margin: const EdgeInsets.all(20),
                      color: Colors.grey,
                      child: const SizedBox(
                        height: 1,
                      ),
                    ),
                    itemCount: ShopCubit.get(context)
                        .getFavoritModel!
                        .data!
                        .data!
                        .length,
                  )
                : const Center(
                    child: Text(
                      'No items has been added to favorite',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
      },
    );
  }

  Padding FivoriteItem(Product model, context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: 120,
                ),
                if (model.discount != 0)
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          model.price.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.2,
                            color: DefaultColor,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (model.discount != 0)
                          Text(
                            model.oldPrice.toString(),
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
                            ShopCubit.get(context).changefavorites(model.id!);
                          },
                          icon: Icon(
                              color:
                                  ShopCubit.get(context).favoriteList[model.id]!
                                      ? Colors.red
                                      : Colors.grey,
                              ShopCubit.get(context).favoriteList[model.id]!
                                  ? Icons.favorite
                                  : Icons.favorite_outline),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
