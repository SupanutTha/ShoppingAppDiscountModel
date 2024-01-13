// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:example9/dicountModule.dart';
import 'package:example9/discountCampaign.dart';
import 'package:example9/widgets/diaglogBox.dart';
import 'package:flutter/material.dart';
import 'productModel.dart';
import 'package:collection/collection.dart';

main() {
  return runApp(
    MaterialApp(
      home: HomePage(),
    ),
  );
} //ef

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //FIXME: rename variable
  int? _couponTypeSelect = null;
  int? _onTopTypeSelect = null;
  int? _seasonalTypeSelect = null;
  TextEditingController _fixAmountController = TextEditingController();
  TextEditingController _percentageDiscountController = TextEditingController();
  //FIXME: remove this line
  String _categoryDiscountController = 'Clothing';
  TextEditingController _percentageDiscountAmountController = TextEditingController();
  TextEditingController _customerPointController = TextEditingController();
  //FIXME: naming
  TextEditingController _everyXController = TextEditingController();
  TextEditingController _discountYController = TextEditingController();
  
  DiscountModule discountModule = DiscountModule(cart, discounts);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar
      appBar: AppBar(title: const Text("AppBar"), actions: []),
      //body
      body: Row(
        children: [
          Expanded(
            //left part
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  //Product Grid
                  flex: 3,
                  child: GridView.builder(
                    //section to define column number, x and y spacing
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5.0, //x spacing
                      mainAxisSpacing: 5.0, //y spacing
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      //put your item rendering here
                      return GestureDetector(
                        onTap: () {
                          //print(products[index].name);
                          //add the selected product into the cart

                          setState(() {
                            addProductToCart(products[index]);
                            discountModule.applyDiscount(cart, discounts);
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(products[index].picture),
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  color: Colors.black54,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text("${products[index].name} ${products[index].price}",
                                        style: style1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                    //Campaign Select
                    flex: 4,
                    child: Column(
                      children: [
                        SizedBox(
                                height: 10,
                              ),
                        Text("Coupon campaign"),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10.0),
                            Wrap(
                              spacing: 15.0,
                              children: List<Widget>.generate(
                                2,
                                (int index) {
                                  return ChoiceChip(
                                    label: index == 0
                                        ? Text("Fix amount")
                                        : Text("Percentage discount"),
                                    selected: _couponTypeSelect == index,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        if(_couponTypeSelect == index) {
                                          _couponTypeSelect = null;
                                        } else {
                                          _couponTypeSelect = index;
                                        }
                                      });
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Visibility(
                          visible: _couponTypeSelect != null,
                          child: TextField(
                            controller:  _fixAmountController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Fix Amount',
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _couponTypeSelect == 1,
                          child: TextField(
                            controller:  _percentageDiscountController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Percentage Amount',
                            ),
                          ),
                        ),
                        SizedBox(
                                height: 10,
                              ),
                        Text("On-Top campaign"),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10.0),
                            Wrap(
                              spacing: 15.0,
                              children: List<Widget>.generate(
                                2,
                                (int index) {
                                  return ChoiceChip(
                                    label: index == 0
                                        ? Text("% discount by category")
                                        : Text("Discount by points"),
                                    selected: _onTopTypeSelect == index,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _onTopTypeSelect = selected
                                            ? (_onTopTypeSelect == index
                                                ? null
                                                : index)
                                            : null;
                                      });
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Visibility(
                          visible: _onTopTypeSelect == 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButton(
                                  value: _categoryDiscountController, //selected option
                                  icon: Icon(Icons.arrow_downward_rounded),
                                  onChanged: ( newVal) {
                                    setState(() {
                                      _categoryDiscountController = newVal ?? 'Clothing'; // Set a default value if newVal is null
                                    });
                                  },
                                  items: [
                                    //FIXME: ProductCategory
                                    for (String category in ['Clothing', 'Accessories', 'Electronics'])
                                      DropdownMenuItem(
                                        value: category,
                                        child: Text(category),
                                      ),
                                  ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                width: 150,
                                child: TextField(
                                  controller: _percentageDiscountAmountController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Amount',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Visibility(
                          visible: _onTopTypeSelect == 1,
                          child: TextField(
                            controller: _customerPointController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Customer points',
                            ),
                          ),
                        ),
                        SizedBox(
                                height: 10,
                              ),
                        Text("Seasonal campaign"),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10.0),
                            Wrap(
                              spacing: 15.0,
                              children: List<Widget>.generate(
                                1,
                                (int index) {
                                  return ChoiceChip(
                                    label: Text("Special campaigns"),
                                    selected: _seasonalTypeSelect == index,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        //FIXME: refactor
                                        _seasonalTypeSelect = selected
                                            ? (_seasonalTypeSelect == index
                                                ? null
                                                : index)
                                            : null;
                                      });
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Visibility(
                          visible: _seasonalTypeSelect == 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150,
                                child: TextField(
                                  controller: _everyXController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    //FIXME:
                                    labelText: 'Enter EveryX',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 150,
                                child: TextField(
                                  controller: _discountYController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    //FIXME:
                                    labelText: 'Enter Discount Y',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
  
                   OutlinedButton(
                      style: OutlinedButton.styleFrom(
                    
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('apply discount'),
                      onPressed: () {
                        discounts.clear();
                        //FIXME: separate function
                        if (_couponTypeSelect == 0 ){
                          try {
                            double value = double.parse(_fixAmountController.text);
                            //FIXME:
                            discounts.add(Discount(type: 'FixedAmount', value: value, apply: true));

                          } catch (e) {
                            print('Invalid input: ${_fixAmountController.text}');
                          }
                        }
                        else if (_couponTypeSelect == 1 ){
                          try {
                            double value = double.parse(_percentageDiscountController.text);
                            //FIXME:
                            discounts.add(Discount(type: 'PercentageDiscount', value: value, apply: true));

                          } catch (e) {
                            print('Invalid input: ${_percentageDiscountController.text}');
                          }
                        }
                        if (_onTopTypeSelect == 0 ){
                          try {
                            String category= _categoryDiscountController;
                            double percentage = double.parse(_percentageDiscountAmountController.text);
                            //FIXME:
                            discounts.add(Discount(type: 'PercentageDiscountByCategory', value: {'category':category, 'amount':percentage}, apply: true));
                          } catch (e) {
                            print('Invalid input: ${_percentageDiscountAmountController.text}');
                            print('Invalid input: ${_categoryDiscountController}');

                          }
                         
                        }
                        else if (_onTopTypeSelect == 1 ){
                          try {
                          double  value = double.parse(_customerPointController.text);
                          discounts.add(Discount(type: 'DiscountByPoints', value: value, apply: true));
                          } catch (e) {
                            print('Invalid input: ${_customerPointController.text}');
                          }
                        }

                        if (_seasonalTypeSelect == 0 ){
                          try {
                          double x = double.parse(_everyXController.text);
                          double y = double.parse(_discountYController.text);
                          if (x>y){
                             discounts.add(Discount(type: 'SpecialCampaigns', value: {'everyX': x  ,'discountY':y}, apply: true));
                          }
                          else {
                            CustomAlertDialog(content: 'test',title: "test2");
                          }
                          } catch (e) {
                            print('Invalid input: ${_everyXController.text}');
                            print('Invalid input: ${_discountYController.text}');
                          }
                        }
                        discountModule.applyDiscount(cart, discounts);
                        setState(() {
                          
                        });
                        print(discounts);
                      },
                    )
              ],
            ),
          ),
          Expanded( // right part
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Row( // label of cart
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Add/Remove"))),
                          Expanded(
                              // name column
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Name"))),
                          Expanded(
                              // description column
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Category"))),
                          Expanded(
                              // description column
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Qty"))),       
                          Expanded(
                              // item total column
                              flex: 1,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Amount")))
                        ],
                      )),
                  const Divider(
                    // line below header
                    height: 20,
                    thickness: 1,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.black,
                  ),
                  Expanded(
                      flex: 8,
                      child: ListView.builder( // item in cart
                        itemCount: cart.length,
                        itemBuilder: (BuildContext context, int index) {
                          String column3 =
                              (cart[index].price * cart[index].qty).toString();
                          return Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              // add or remove button column
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: MaterialButton(
                                                      color: Colors.black54,
                                                      shape: CircleBorder(),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.green,
                                                      ),
                                                      onPressed: () {
                                                        // do something
                                                        setState(() {
                                                          addProductToCart(
                                                              cart[index]);
                                                          discountModule.applyDiscount(cart, discounts);
                                                        }
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: MaterialButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          removeProductFromCart(
                                                              cart[index]);
                                                          discountModule.applyDiscount(cart, discounts);
                                                        });
                                                      },
                                                      color: Colors.black54,
                                                      shape: CircleBorder(),
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                              // name column
                                              flex: 1,
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child:
                                                      Text(cart[index].name))),
                                          Expanded(
                                              // description column
                                              flex: 1,
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(cart[index].category))),
                                           Expanded(
                                              // description column
                                              flex: 1,
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text("${cart[index].qty.toString()}"))),
                                          Expanded(
                                              // item total column
                                              flex: 1,
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(column3))),
                                        ],
                                      ),
                                      const Divider(
                                        // line below head
                                        height: 20,
                                        thickness: 1,
                                        indent: 20,
                                        endIndent: 0,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ))
                            ],
                          );
                        },
                      )),
                      Divider(color: Colors.black45,),
                      Expanded(flex :1 , child: Text("Sub total ${calculateGrandTotal(cart)}")),
                  Visibility( //discount part
                    visible: discounts.isNotEmpty,
                    child: Expanded(
                      flex: 1,
                      child: 
                          ListView.builder(
                            itemCount: discounts.length, 
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                children: [
                                  Row(
                                    children: [
                                      Text("${discounts[index].type} discount ${discountModule.getDiscountInfo(discounts[index])} THB"),
                                      //Text("${discounts[index].value}"),
                                      //Text("${discountModule.getDiscountInfo(discounts[index])}"),
                                    ],
                                  ),
                                  //Text("${discounts[index].type} every ${discounts[index].value['everyX']} THB discount ${discounts[index].value['discountY']} THB "),
                                ],
                              );
                            },
                          )


                    ),
                  ),
                  const Divider(
                    // line below head
                    height: 20,
                    thickness: 1,
                    indent: 20,
                    endIndent: 0,
                    color: Colors.black,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("Total: ${discountModule.totalPriceAfterDiscount}"),
                  )
                ],
              ))
        ],
      ),
    );
  }

  addProductToCart(Product product) {
    var check = cart.firstWhereOrNull((p) => p.id == product.id);
    if (check == null) {
      cart.add(product);
      //print(cart);
    } else {
      check.qty += 1;
    }
  } //ef
} //ec

removeProductFromCart(Product product) {
  if (product.qty - 1 == 0) {
    cart.remove(product);
  } else {
    product.qty -= 1;
  }
}


TextStyle style1 = TextStyle(fontSize: 20, color: Colors.white60);
