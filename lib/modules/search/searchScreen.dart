import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/state.dart';

import '../../cubit/cubit.dart';
import '../../rewidget.dart';
import '../../style/them.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    REFormField(
                      onsave: (String value) {
                        SearchCubit.get(context).search(value);
                      },
                      obscureText: false,
                      controller: searchTextController,
                      type: TextInputType.text,
                      label: const Text('Search'),
                      prefix: const Icon(Icons.search),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'The value should not be empty';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => FivoriteItem(
                              SearchCubit.get(context).searchmodel!.data!.data!,
                              context),
                          separatorBuilder: (context, index) => Container(
                            margin: const EdgeInsets.all(20),
                            color: Colors.grey,
                            child: const SizedBox(
                              height: 1,
                            ),
                          ),
                          itemCount: SearchCubit.get(context)
                              .searchmodel!
                              .data!
                              .data!
                              .length,
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding FivoriteItem(var model, context) {
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
                  image: NetworkImage(model.image),
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
