import 'package:flutter/material.dart';
import 'package:foodapp/data/repository/cart_repo.dart';
import 'package:foodapp/models/cart_model.dart';
import 'package:foodapp/models/product_model.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items=> _items;
  List<CartModel> storageItems=[];

  void addItems(ProductsModel product, int quantity) {
    var totalQuantity = 0;
    /*print("lenght of the items is" + _items.length.toString());
    _items.forEach((key, value) {
      print("quantity is : "+value.quantity.toString());
    });*/
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value){

        totalQuantity = value.quantity!+ quantity;

        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if(totalQuantity<=0){
        _items.remove(product.id);
      }
    } else{
      if(quantity>0){
        _items.putIfAbsent(product.id!, () {
          print("adding items to the cart id ${product.id!} quantity : ${quantity}");
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar("Item count", "You should add One item in the cart !", backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getItems);
      update();
  }

  existInCart(ProductsModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  int getQuantity(ProductsModel product){
    var quantity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key == product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQunatity = 0;
    _items.forEach((key, value) {
      totalQunatity += value.quantity!;
    });
      return totalQunatity;
   }

   List<CartModel> get getItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
   }

   int get totalAmount{

    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity!*value.price!;
    });

    return total;
}

   List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
      return storageItems;
   }

   set setCart(List<CartModel> items){
    storageItems=items;
    //print("Length of the cart item is:"+ storageItems.length.toString());
    for(int i=0; i<storageItems.length; i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
   }

   void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
   }

   void clear(){
     _items={};
     update();
   }

   List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
   }

   set setItems(Map<int, CartModel> setItems){
      _items = {};
      _items = setItems;
   }

   void addToCartList(){
     cartRepo.addToCartList(getItems);
     update();
   }

   void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
   }
}
