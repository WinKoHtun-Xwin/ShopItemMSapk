







// import 'package:auth_with_bloc/core/base/model/category_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_treeview/flutter_treeview.dart';
//
// import '../../core/base/bloc/auth_bloc.dart';
// import '../../core/base/service/category/category_create_service.dart';
// import '../../core/components/appbar/appbar.dart';
// import '../../core/components/button/button.dart';
// import '../../core/components/dropdown.dart';
// import '../../core/components/text/custom_text.dart';
// import '../../core/components/textFormField/text_form_field.dart';
// import '../../core/constants/app/color_constants.dart';
// import '../../core/constants/app/string_constants.dart';
// import '../../core/constants/enums/icon_enums.dart';
// import '../../core/extensions/context_extensions.dart';
// import '../../core/extensions/image_extensions.dart';
// import '../../core/extensions/num_extensions.dart';
// import '../../core/utils/validate_operations.dart';
//
//
// class category_create_view extends StatefulWidget {
//   const category_create_view({Key? key}) : super(key: key);
//
//   @override
//   State<category_create_view> createState() => _CreateCategoryViewState();
// }
//
// class _CreateCategoryViewState extends State<category_create_view> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController categoryNameController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   late List<DropdownMenuItem<String>> parentCategoryDropdownItems;
//   String? selectedParentCategoryId;
//
//   bool? get validate => _formKey.currentState?.validate();
//
//   List<CategoryModel> cList = []; // Initialize cList as an empty list
//
//   @override
//   void initState() {
//     super.initState();
//     parentCategoryDropdownItems = _buildParentCategoryDropdownItems();
//   }
//
//
//   List<DropdownMenuItem<String>> _buildParentCategoryDropdownItems() {
//     List<DropdownMenuItem<String>> items = [];
//
//     for (CategoryModel category in cList) {
//       items.add(
//         DropdownMenuItem(
//           value: category.CategoryId,
//           child: Text(category.CategoryName ?? ''),
//         ),
//       );
//     }
//
//     return items;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: context.dynamicWidth(0.05),
//           ),
//           child: Center(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _CategoryNameFormField(categoryNameController: categoryNameController),
//                   _CategoryDescriptionFormField(descriptionController: descriptionController),
//                   DropdownButtonFormField<String>(
//                     value: selectedParentCategoryId,
//                     items: parentCategoryDropdownItems,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedParentCategoryId = value;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Parent Category',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                         borderSide: BorderSide(color: ColorConstants.teal),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: const BorderSide(color: ColorConstants.teal)),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: const BorderSide(color: ColorConstants.teal)),
//                       errorBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(15),
//                           borderSide: const BorderSide(color: Colors.red)),
//                     ),
//                   ),
//                   _CreateCategoryButton(
//                     onTap: () async {
//                       if (validate != null && validate == true) {
//                         try {
//
//                           // Handle the created category as needed
//
//                         } catch (e) {
//
//                         }
//                       }
//                     },
//                   ),
//                   _CategoryListWidget(
//                     categoryList: cList,
//                     onEdit: (category) {
//                       print('Edit ${category.CategoryId}');
//                     },
//                     onDelete: (category) {
//                       print('Delete ${category.CategoryId}');
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:auth_with_bloc/core/base/model/category_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:rxdart/rxdart.dart';

import '../../core/base/bloc/auth_bloc.dart';
import '../../core/base/service/category/category_service.dart'; // Update this import
import '../../core/components/appbar/appbar.dart';
import '../../core/components/button/button.dart';
import '../../core/components/dropdown.dart';
import '../../core/components/text/custom_text.dart';
import '../../core/components/textFormField/text_form_field.dart';
import '../../core/constants/app/color_constants.dart';
import '../../core/constants/app/string_constants.dart';
import '../../core/constants/enums/icon_enums.dart';
import '../../core/extensions/context_extensions.dart';
import '../../core/extensions/image_extensions.dart';
import '../../core/extensions/num_extensions.dart';
import '../../core/utils/validate_operations.dart';

class category_create_view extends StatefulWidget {
  const category_create_view({Key? key}) : super(key: key);

  @override
  State<category_create_view> createState() => _CreateCategoryViewState();
}

class _CreateCategoryViewState extends State<category_create_view> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController categoryNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late List<DropdownMenuItem<String>> parentCategoryDropdownItems;
  String? selectedParentCategoryId;
  List<CategoryModel> cList = [];
  bool? get validate => _formKey.currentState?.validate();

  CategoryService _categoryService = CategoryService(Dio()); // Create an instance of your CategoryService
  @override
  void initState() {
    super.initState();
    parentCategoryDropdownItems = _buildParentCategoryDropdownItems();
    _fetchCategoryList();
  }

  void _fetchCategoryList() async {
    try {
      // Use your CategoryService to get all categories
      List<CategoryModel> fetchedCategoryList = await _categoryService.GetAllCategory('eyJhbGciOiJBMjU2S1ciLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIiwidHlwIjoiSldUIn0._5FiVv1s3MiFBIyQzAWAcK0AtFDOinfsowOOOAc5wkn8WBNztQrkk9wYTn-B9b3JFT1jJrdT2-M2P5DzzDNBPUFJCD3u8G--.41n5Fegh4BpVhBP_W0vYZA.Q5FLaBuclbpB3wlLZ3PPP51yP4sJYgwC-0vzPm6qwKlvU6-y6sM4pjWFV68jpMjf19hCH_vhf7hIYdRvPrxAS3e9cyG-cFocBvC5gpRJ-IUyOmHcYylo9JJcx3h5GxOLpzcBV8u1NbJGX6F8bMGg8RdqpD-1TrN6xckT7ehDFZsiQEi0JJu-rtOVhtXhXZzP6eW7Z1BYoycLQifvWEA87sDQlSRj94Hqf14vbcmhIEthnK4luTZsA65xpDbeZwiq7M9mX-5fnJLMK26I_RE-MKaLf6i-urfLmV-dPeekw6aD2DYyqpNkeItnSyO5AbM5ASfx6FN5TV7srcCXdoO9ErqRhywsx3cJtKMvOx1spQ2FIVuarNmEmDH1FKvSVFDSm9nHmLXkOoAPmfRZM5C2CueHzWuSlS4oCZeOgvdSYwgKXu8H0xj5dJANNjs5cGTpe8KrjDPcCZ7XmsH_xM7Wo_Ks60QeLE6Sjj6aCwGjLRAJ_Bv0GQQM9t40yKQVjKZ6.QwM_x-JcRd9FyIqg5bdQiA9Rr4Gk_8dc_UxwuStmx1g');

      setState(() {
        // Update cList with the fetched categories
         cList = fetchedCategoryList;
      });
    } catch (e) {
      // Handle errors
    }
  }


  List<DropdownMenuItem<String>> _buildParentCategoryDropdownItems() {
    List<DropdownMenuItem<String>> items = [];

    // Assume you have a method in CategoryService to get all categories
    _categoryService.GetAllCategory('Bearer eyJhbGciOiJBMjU2S1ciLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIiwidHlwIjoiSldUIn0._5FiVv1s3MiFBIyQzAWAcK0AtFDOinfsowOOOAc5wkn8WBNztQrkk9wYTn-B9b3JFT1jJrdT2-M2P5DzzDNBPUFJCD3u8G--.41n5Fegh4BpVhBP_W0vYZA.Q5FLaBuclbpB3wlLZ3PPP51yP4sJYgwC-0vzPm6qwKlvU6-y6sM4pjWFV68jpMjf19hCH_vhf7hIYdRvPrxAS3e9cyG-cFocBvC5gpRJ-IUyOmHcYylo9JJcx3h5GxOLpzcBV8u1NbJGX6F8bMGg8RdqpD-1TrN6xckT7ehDFZsiQEi0JJu-rtOVhtXhXZzP6eW7Z1BYoycLQifvWEA87sDQlSRj94Hqf14vbcmhIEthnK4luTZsA65xpDbeZwiq7M9mX-5fnJLMK26I_RE-MKaLf6i-urfLmV-dPeekw6aD2DYyqpNkeItnSyO5AbM5ASfx6FN5TV7srcCXdoO9ErqRhywsx3cJtKMvOx1spQ2FIVuarNmEmDH1FKvSVFDSm9nHmLXkOoAPmfRZM5C2CueHzWuSlS4oCZeOgvdSYwgKXu8H0xj5dJANNjs5cGTpe8KrjDPcCZ7XmsH_xM7Wo_Ks60QeLE6Sjj6aCwGjLRAJ_Bv0GQQM9t40yKQVjKZ6.QwM_x-JcRd9FyIqg5bdQiA9Rr4Gk_8dc_UxwuStmx1g').then((categoryList) {
      for (CategoryModel category in categoryList) {
        items.add(
          DropdownMenuItem(
            value: category.CategoryId,
            child: Text(category.CategoryName ?? ''),
          ),
        );
      }
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.dynamicWidth(0.05),
          ),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CategoryNameFormField(categoryNameController: categoryNameController),
                  _CategoryDescriptionFormField(descriptionController: descriptionController),
                  DropdownButtonFormField<String>(
                    value: selectedParentCategoryId,
                    items: parentCategoryDropdownItems,
                    onChanged: (value) {
                      setState(() {
                        selectedParentCategoryId = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Parent Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(color: ColorConstants.teal),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: ColorConstants.teal)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: ColorConstants.teal)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.red)),
                    ),
                  ),
                  _CreateCategoryButton(
                    onTap: () async {
                      // if (validate != null && validate == true) {
                        try {

                          // Use your CategoryService to create a category
                         var response= await _categoryService.CreateCategory('Bearer eyJhbGciOiJBMjU2S1ciLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIiwidHlwIjoiSldUIn0._5FiVv1s3MiFBIyQzAWAcK0AtFDOinfsowOOOAc5wkn8WBNztQrkk9wYTn-B9b3JFT1jJrdT2-M2P5DzzDNBPUFJCD3u8G--.41n5Fegh4BpVhBP_W0vYZA.Q5FLaBuclbpB3wlLZ3PPP51yP4sJYgwC-0vzPm6qwKlvU6-y6sM4pjWFV68jpMjf19hCH_vhf7hIYdRvPrxAS3e9cyG-cFocBvC5gpRJ-IUyOmHcYylo9JJcx3h5GxOLpzcBV8u1NbJGX6F8bMGg8RdqpD-1TrN6xckT7ehDFZsiQEi0JJu-rtOVhtXhXZzP6eW7Z1BYoycLQifvWEA87sDQlSRj94Hqf14vbcmhIEthnK4luTZsA65xpDbeZwiq7M9mX-5fnJLMK26I_RE-MKaLf6i-urfLmV-dPeekw6aD2DYyqpNkeItnSyO5AbM5ASfx6FN5TV7srcCXdoO9ErqRhywsx3cJtKMvOx1spQ2FIVuarNmEmDH1FKvSVFDSm9nHmLXkOoAPmfRZM5C2CueHzWuSlS4oCZeOgvdSYwgKXu8H0xj5dJANNjs5cGTpe8KrjDPcCZ7XmsH_xM7Wo_Ks60QeLE6Sjj6aCwGjLRAJ_Bv0GQQM9t40yKQVjKZ6.QwM_x-JcRd9FyIqg5bdQiA9Rr4Gk_8dc_UxwuStmx1g',
                              CategoryModel(
                                  CategoryId: '',
                                  CategoryName:categoryNameController.text,
                                  ParentCategoryId: '',
                                  Description:descriptionController.text
                          ));
                         if (response!=null) {
                           // If the status code is OK (200), show a success message using SnackBar
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                               content: Text('New Category created successfully'),
                               duration: Duration(seconds: 2), // Adjust the duration as needed
                             ),
                           );

                           categoryNameController.text='';
                           descriptionController.text='';
                         } else {
                           // Handle other status codes if needed
                           print('Request failed with status: ${response}');
                         }

                          // Handle the created category as needed
                        } catch (e) {
                          // Handle errors
                        }
                      }
                    // },
                  ),
                  _CategoryListWidget(
                    categoryList: cList,
                    onEdit: (category) {
                      print('Edit ${category.CategoryId}');
                    },
                    onDelete: (category) async {
                      try {
                        // Use your CategoryService to delete a category
                        await _categoryService.deleteCategory('Bearer eyJhbGciOiJBMjU2S1ciLCJlbmMiOiJBMjU2Q0JDLUhTNTEyIiwidHlwIjoiSldUIn0._5FiVv1s3MiFBIyQzAWAcK0AtFDOinfsowOOOAc5wkn8WBNztQrkk9wYTn-B9b3JFT1jJrdT2-M2P5DzzDNBPUFJCD3u8G--.41n5Fegh4BpVhBP_W0vYZA.Q5FLaBuclbpB3wlLZ3PPP51yP4sJYgwC-0vzPm6qwKlvU6-y6sM4pjWFV68jpMjf19hCH_vhf7hIYdRvPrxAS3e9cyG-cFocBvC5gpRJ-IUyOmHcYylo9JJcx3h5GxOLpzcBV8u1NbJGX6F8bMGg8RdqpD-1TrN6xckT7ehDFZsiQEi0JJu-rtOVhtXhXZzP6eW7Z1BYoycLQifvWEA87sDQlSRj94Hqf14vbcmhIEthnK4luTZsA65xpDbeZwiq7M9mX-5fnJLMK26I_RE-MKaLf6i-urfLmV-dPeekw6aD2DYyqpNkeItnSyO5AbM5ASfx6FN5TV7srcCXdoO9ErqRhywsx3cJtKMvOx1spQ2FIVuarNmEmDH1FKvSVFDSm9nHmLXkOoAPmfRZM5C2CueHzWuSlS4oCZeOgvdSYwgKXu8H0xj5dJANNjs5cGTpe8KrjDPcCZ7XmsH_xM7Wo_Ks60QeLE6Sjj6aCwGjLRAJ_Bv0GQQM9t40yKQVjKZ6.QwM_x-JcRd9FyIqg5bdQiA9Rr4Gk_8dc_UxwuStmx1g', category.CategoryId!);

                        // Handle the deleted category as needed
                      } catch (e) {
                        // Handle errors
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ... (rest of the code remains unchanged)
class _CategoryListWidget extends StatelessWidget {
  const _CategoryListWidget({
    required this.categoryList,
    required this.onEdit,
    required this.onDelete,
  });

  final List<CategoryModel> categoryList;
  final void Function(CategoryModel) onEdit;
  final void Function(CategoryModel) onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'Category List',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (categoryList.isNotEmpty)
          Column(
            children: categoryList.map((category) {
              return ListTile(
                title: Text(category.CategoryName ?? 'Enter Category Name'),
                subtitle: Text(category.Description ?? 'Enter Category Description'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit button click
                        onEdit(category);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Handle delete button click
                        onDelete(category);
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          )
        else
          Text('No categories yet.'),
      ],
    );
  }
}


class _LogoAndTitleWidget extends StatelessWidget {
  const _LogoAndTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.dynamicHeight(0.06),
      ),
      child: Column(
        children: [
          Image.asset(
            IconEnums.appLogo.iconName.toPng,
            height: context.dynamicHeight(0.2),
          ),
          30.ph,
          CustomText(
            StringConstants.loginTitle,
            textStyle: context.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}


class _CategoryNameFormField extends StatelessWidget {
  const _CategoryNameFormField({
    required this.categoryNameController,
  });

  final TextEditingController categoryNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: categoryNameController,
      title: StringConstants.CategoryNameTitle,
      hintText: StringConstants.CategoryNameHint,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        categoryNameController.text = value!;
      },
      validator: (value) => ValidateOperations.normalValidation(value),
    );
  }
}

class _CategoryDescriptionFormField extends StatelessWidget {
  const _CategoryDescriptionFormField({
    required this.descriptionController,
  });

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      controller: descriptionController,
      title: StringConstants.CategoryDescTitle,
      hintText: StringConstants.CategoryDescHint,
      isPassword: false,
      onSaved: (value) {
        descriptionController.text = value!;
      },
    );
  }
}

class _CreateCategoryButton extends StatelessWidget {
  const _CreateCategoryButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      buttonText: StringConstants.CreateCategoryButtonText,
      onTap: onTap,
    );
  }
}

