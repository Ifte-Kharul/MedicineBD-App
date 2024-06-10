import 'dart:developer';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:image/image.dart' as img;
import 'package:admin_medic/db/brand.dart';
import 'package:admin_medic/db/category.dart';
import 'package:admin_medic/utils/k_constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../db/product.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService categoryService = CategoryService();
  ProductServices productServices = ProductServices();
  BrandService brandService = BrandService();
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productGroupController = TextEditingController();
  List<DocumentSnapshot> brands = [];
  List<DocumentSnapshot> categories = [];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String? _currentCategory;
  String? _currentBrand;

  XFile? fileImage1;
  XFile? fileImage2;
  XFile? fileImage3;
  bool isLoading = false;
  @override
  void initState() {
    _getCategories();
    _getBrands();

    // brandsDropDown = getBrandsDropDown();
    // _currentBrand = brandsDropDown[0].value;
    // _currentCategory = categoriesDropDown[0].value;
    super.initState();
  }

  _getCategories() async {
    List<DocumentSnapshot> data = await categoryService.getCategories();
    // var d = data[0]['category'];
    // log(d.toString());
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropDown();
      _currentCategory = categories[0]['category'];
      log(categories.length.toString());
      // log(categories.length.toString());
    });
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await brandService.getBrands();
    setState(() {
      brands = data;
      brandsDropDown = getBrandsDropDown();
      _currentBrand = brands[0]['brand'];
    });
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              value: categories[i]['category'],
              child: Text(categories[i]['category']),
            ));
      });
    }
    return items;
  }

  List<DropdownMenuItem<String>> getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = [];
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              value: brands[i]['brand'],
              child: Text(brands[i]['brand']),
            ));
      });
    }
    // for (DocumentSnapshot brand in brands) {
    //   items.add(DropdownMenuItem(
    //     value: brand['brand'],
    //     child: Text(brand['brand']),
    //   ));
    // }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            )),
        title: const Text(
          "Add Product",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                            onPressed: () {
                              _selectIMG(
                                  ImagePicker()
                                      .pickImage(source: ImageSource.gallery),
                                  1);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.8),
                                width: 3.0,
                              ),
                            ),
                            child: displayChild1(),
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: OutlinedButton(
                      //       onPressed: () {
                      //         _selectIMG(
                      //             ImagePicker()
                      //                 .pickImage(source: ImageSource.gallery),
                      //             2);
                      //       },
                      //       style: OutlinedButton.styleFrom(
                      //         side: BorderSide(
                      //           color: Colors.grey.withOpacity(0.8),
                      //           width: 3.0,
                      //         ),
                      //       ),
                      //       child: displayChild2(),
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: OutlinedButton(
                      //       onPressed: () {
                      //         _selectIMG(
                      //             ImagePicker()
                      //                 .pickImage(source: ImageSource.gallery),
                      //             3);
                      //       },
                      //       style: OutlinedButton.styleFrom(
                      //         side: BorderSide(
                      //           color: Colors.grey.withOpacity(0.8),
                      //           width: 3.0,
                      //         ),
                      //       ),
                      //       child: displayChild3(),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  TextFormField(
                    controller: _productNameController,
                    decoration: const InputDecoration(
                      hintText: "Product Name",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kAppbarColor, width: 1.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You Must Enter Product Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  //select Category
                  Row(
                    children: [
                      // ignore: prefer_const_constructors
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: const Text(
                          'Category : ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      DropdownButton(
                        items: categoriesDropDown,
                        onChanged: ((value) =>
                            changeSelectedCategory(value.toString())),
                        value: _currentCategory,
                      ),
                      //Brand
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Text(
                          'Brand : ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      DropdownButton(
                        items: brandsDropDown,
                        onChanged: ((value) =>
                            changeSelectedBrand(value.toString())),
                        value: _currentBrand,
                      ),
                    ],
                  ),

                  TextFormField(
                    controller: _productGroupController,
                    decoration: const InputDecoration(
                      hintText: "Product Group",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kAppbarColor, width: 1.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You Must Enter Product Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _productPriceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Product Price",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kAppbarColor, width: 1.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You Must Enter Product Price";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _productDescriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      hintText: "Product Description",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kAppbarColor, width: 1.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You Must Enter Product Description";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        validateAndUpload();
                      },
                      child: const Text('Add Product'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kAppbarColor),
                    ),
                  )
                  //brand Dropdown

                  // Center(
                  //   child: DropdownButton(
                  //       value: _currentCategory,
                  //       items: categoriesDropDown,
                  //       onChanged:
                  //           changeSelectedCategory(_currentCategory.toString())),
                  // ),
                  // Center(
                  //   child: DropdownButton(
                  //       value: _currentBrand,
                  //       items: brandsDropDown,
                  //       onChanged: changeSelectedCategory(_currentBrand.toString())),
                  // ),
                ],
              ),
      ),
    );
  }

  changeSelectedCategory(String selectCategory) {
    setState(() {
      _currentCategory = selectCategory;
    });
  }

  changeSelectedBrand(String selectBrand) {
    setState(() {
      _currentBrand = selectBrand;
    });
  }

  void _selectIMG(Future<XFile?> pickImage, int num) async {
    XFile? tempi = await pickImage;
    switch (num) {
      case 1:
        setState(() {
          fileImage1 = tempi;
        });
        break;
      case 2:
        setState(() {
          fileImage2 = tempi;
        });
        break;
      case 3:
        setState(() {
          fileImage3 = tempi;
        });
        break;
    }
    // fileImage1 = await pickImage;
  }

  Widget displayChild1() {
    if (fileImage1 == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 14.0),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      // if(fileImage1!=null){
      //   final path = fileImage1!.path;
      // final bytes = fileImage1!.readAsBytes();

      //   final img.Image image = img.decodeImage(bytes);
      // }

      return Image(
        image: XFileImage(fileImage1!),
        fit: BoxFit.cover,
      );
    }
  }

  Widget displayChild2() {
    if (fileImage2 == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 14.0),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      // if(fileImage1!=null){
      //   final path = fileImage1!.path;
      // final bytes = fileImage1!.readAsBytes();

      //   final img.Image image = img.decodeImage(bytes);
      // 3

      return Image(
        image: XFileImage(fileImage2!),
        fit: BoxFit.cover,
      );
    }
  }

  Widget displayChild3() {
    if (fileImage3 == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 14.0),
        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      // if(fileImage1!=null){
      //   final path = fileImage1!.path;
      // final bytes = fileImage1!.readAsBytes();

      //   final img.Image image = img.decodeImage(bytes);
      // }

      return Image(
        image: XFileImage(fileImage3!),
        fit: BoxFit.cover,
      );
    }
  }
  // File convertToFile(XFile? xfile){
  //   var bits = xfile!.readAsBytes;

  //     return File(fileBits, fileName)
  // }
  Future<void> validateAndUpload() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      if (fileImage1 != null) {
        String imgUrl;
        // String imgUr2;
        // String imgUrl3;
        FirebaseStorage storage = FirebaseStorage.instance;
        // Reference referenceRoot =FirebaseStorage.instance.ref();
        // Reference referenceDirImages =referenceRoot.child('pictures');

        final String pic1 =
            "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        // Reference imgToUp=referenceDirImages.child(pic1);
        // imgToUp.putFile(File(path))
        var task1 = storage.ref().child(pic1);
        var up1 = task1.putFile(File(fileImage1!.path));
        // final String pic2 =
        //     "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        // var task2 = storage.ref().child(pic2);
        // var up2 = task2.putFile(File(fileImage2!.path));
        // final String pic3 =
        //     "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        // var task3 = storage.ref().child(pic3);
        // var up3 = task3.putFile(File(fileImage3!.path));

        TaskSnapshot snap1 = await up1.then((value) {
          return value;
        });
        // TaskSnapshot snap2 = await up2.then((value) {
        //   return value;
        // });

        up1.then((value) async {
          // imgUrl= await snap1.getDownloadURL();
          imgUrl = await task1.getDownloadURL();
          // imgUr2 = await task2.getDownloadURL();
          // imgUrl3 = await task3.getDownloadURL();
          String imgList = imgUrl;

          productServices.UploadProduct(
            productName: _productNameController.text,
            brand: _currentBrand!,
            category: _currentCategory!,
            group: _productGroupController.text,
            price: _productPriceController.text,
            desc: _productDescriptionController.text,
            imgList: imgList,
          );
          _formKey.currentState!.reset();
        });
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Product Added");
        Navigator.of(context).pop();
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: 'All the images must be provided');
      }
    }
  }
}
