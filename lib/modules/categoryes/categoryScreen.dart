import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categoriesModel.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => BuildIteam(
              ShopCubit.get(context).categoriesModel!.Data!.data![index]),
          separatorBuilder: (context, index) => Container(
            margin: const EdgeInsets.all(20),
            color: Colors.grey,
            child: const SizedBox(
              height: 1,
            ),
          ),
          itemCount: ShopCubit.get(context).categoriesModel!.Data!.data!.length,
        );
      },
    );
  }

  Padding BuildIteam(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            model.name!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
          )
        ],
      ),
    );
  }
}
