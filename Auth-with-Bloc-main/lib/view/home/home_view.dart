// import 'package:auth_with_bloc/core/components/appbar/appbar.dart';
// import 'package:auth_with_bloc/core/components/text/custom_text.dart';
// import 'package:auth_with_bloc/core/constants/app/string_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../core/base/bloc/product/productSerarch/product_search_bloc.dart';
// import '../../core/base/bloc/product/product_list_cubit.dart';
// import '../../core/base/model/product_model.dart';
//
// // class HomeView extends StatefulWidget {
// //   const HomeView({super.key});
// //
// //   @override
// //   State<HomeView> createState() => _HomeViewState();
// // }
//
//
// class HomeView extends StatefulWidget {
//   const HomeView({Key? key}) : super(key: key);
//
//   @override
//   _HomeViewState createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     BlocProvider.of<ProductListCubit>(context).getProductList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SearchProductBloc searchCountryBloc =
//     BlocProvider.of<SearchProductBloc>(context);
//     return Scaffold(
//       appBar: CustomAppBar(isHome: true),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SearchAnchor(
//               isFullScreen: false,
//               builder: (context, controller) {
//                 controller.addListener(() {
//                   if (controller.text.isNotEmpty) {
//                     searchCountryBloc.add(SearchProduct(controller.text));
//                   }
//                 });
//                 return SearchBar(
//                   onTap: () {
//                     controller.openView();
//                   },
//                   hintText: 'Search',
//                 );
//               },
//               suggestionsBuilder: (context, controller) {
//                 return [
//                   BlocBuilder<SearchProductBloc, SearchProductState>(
//                     builder: (context, state) {
//                       if (state is SearchProductSuccess) {
//                         List<ProductModel> countryList = state.productList;
//                         return SizedBox(
//                           height: 500,
//                           child: ListView.builder(
//                             itemCount: countryList.length,
//                             itemBuilder: (context, position) {
//                               ProductModel productModel =
//                               countryList[position];
//                               return Card(
//                                 child: ListTile(
//                                   leading: Image.network(
//                                     (productModel.imageUrl ?? '') + '.png',
//                                     width: 80,
//                                   ),
//                                   title: Text(productModel.name ?? ''),
//                                 ),
//                               );
//                             },
//                           ),
//                         );
//                       } else if (state is SearchProductLoading) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//                       return const Center(
//                         child: Text('Empty'),
//                       );
//                     },
//                   ),
//                 ];
//               },
//             ),
//           ),
//           Expanded(
//             child: BlocBuilder<ProductListCubit, ProductListBlocState>(
//               builder: (context, state) {
//                 if (state is ProductListBlocSuccess) {
//                   List<ProductModel> productList = state.productList;
//                   return ListView.builder(
//                     itemCount: productList.length,
//                     itemBuilder: (context, position) {
//                       ProductModel productModel = productList[position];
//                       return Card(
//                         elevation: 0,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Image.network(
//                                   (productModel.imageUrl ?? '') + '.png',
//                                   width: 80,
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       '${productModel.name}',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .headline6,
//                                     ),
//                                     Text(
//                                         'Capital city : ${productModel.shortName}'),
//                                     Text('Region : ${productModel.categoryName}'),
//                                     // Text(
//                                     //     'SubRegion : ${productModel.subregion}')
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 } else if (state is ProductListBlocFailed) {
//                   return Center(
//                     child: Text('Something wrong ${state.error}'),
//                   );
//                 }
//                 return const Center(child: CircularProgressIndicator());
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_with_bloc/core/components/appbar/appbar.dart';
import 'package:auth_with_bloc/core/components/text/custom_text.dart';
import 'package:auth_with_bloc/core/constants/app/string_constants.dart';

import '../../core/base/bloc/product/productSerarch/product_search_bloc.dart';
import '../../core/base/bloc/product/product_list_cubit.dart';
import '../../core/base/model/product_model.dart';
import '../category/category_create_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<ProductListCubit>(context).getProductList();
  }

  @override
  Widget build(BuildContext context) {
    SearchProductBloc searchCountryBloc =
    BlocProvider.of<SearchProductBloc>(context);
    return Scaffold(
      appBar: CustomAppBar(isHome: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchAnchor(
              isFullScreen: false,
              builder: (context, controller) {
                controller.addListener(() {
                  if (controller.text.isNotEmpty) {
                    searchCountryBloc.add(SearchProduct(controller.text));
                  }
                });
                return SearchBar(
                  onTap: () {
                    controller.openView();
                  },
                  hintText: 'Search',
                );
              },
              suggestionsBuilder: (context, controller) {
                return [
                  BlocBuilder<SearchProductBloc, SearchProductState>(
                    builder: (context, state) {
                      if (state is SearchProductSuccess) {
                        List<ProductModel> countryList = state.productList;
                        return SizedBox(
                          height: 500,
                          child: ListView.builder(
                            itemCount: countryList.length,
                            itemBuilder: (context, position) {
                              ProductModel productModel =
                              countryList[position];
                              return Card(
                                child: ListTile(
                                  leading: Image.network(
                                    (productModel.imageUrl ?? '') ,
                                    width: 80,
                                  ),
                                  title: Text(productModel.name ?? ''),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is SearchProductLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return const Center(
                        child: Text('Empty'),
                      );
                    },
                  ),
                ];
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductListCubit, ProductListBlocState>(
              builder: (context, state) {
                if (state is ProductListBlocSuccess) {
                  List<ProductModel> productList = state.productList;
                  return ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, position) {
                      ProductModel productModel = productList[position];
                      return Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network(
                                  (productModel.imageUrl ?? ''),
                                  width: 80,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text(
                                      '${productModel.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6,
                                    ),
                                    Text(
                                        'Capital city : ${productModel.shortName}'),
                                    Text('Region : ${productModel.categoryName}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ProductListBlocFailed) {
                  return Center(
                    child: Text('Something wrong ${state.error}'),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),

          // Buttons to create a new category and product horizontally
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _createCategory(context);
                },
                icon: Icon(Icons.category),
                label: Text('Create Category'),
              ),
              ElevatedButton.icon(
                onPressed: () {

                },
                icon: Icon(Icons.add),
                label: Text('Create Product'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _createCategory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => category_create_view(),
    );
  }


}
