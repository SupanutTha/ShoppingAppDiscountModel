// import 'package:flutter/material.dart';
// import 'package:shopping_app/models/discount.dart';
// import 'package:shopping_app/viewModels/productViewModel.dart';
// import 'viewModels/discountViewModel.dart';
// import 'widgets/diaglogBox.dart';
// import 'models/product.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   //FIXME: rename variable
//   int? _selectedCouponType;
//   int? _selectedOnTopType;
//   int? _selectedSeasonalType;
//   final TextEditingController _fixAmountController = TextEditingController();
//   final TextEditingController _percentageDiscountController = TextEditingController();
//   //FIXME: remove this line
//   ProductCategory? _selectedCategoryForDiscount;
//   final TextEditingController _percentageDiscountAmountController = TextEditingController();
//   final TextEditingController _customerPointController = TextEditingController();
//   //FIXME: naming
//   final TextEditingController _specialCampaignThresholdController = TextEditingController();
//   final TextEditingController _specialCampaignFixedDiscountController = TextEditingController();

//   late ProductViewModel productViewModel;
//   late DiscountViewModel discountModule;

//   @override
//   void initState() {
//     super.initState();
//     productViewModel = ProductViewModel();
//     discountModule = DiscountViewModel();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //appBar
//       appBar: AppBar(title: const Text("AppBar"), actions: []),
//       //body
//       body: Row(
//         children: [
//           Expanded(
//             //left part
//             flex: 1,
//             child: Column(
//               children: [
//                 Expanded(
//                   //Product Grid
//                   flex: 3,
//                   child: GridView.builder(
//                     //section to define column number, x and y spacing
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 5.0, //x spacing
//                       mainAxisSpacing: 5.0, //y spacing
//                     ),
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       //put your item rendering here
//                       return GestureDetector(
//                         onTap: () {
//                           //add the selected product into the cart
//                           setState(() {
//                             productViewModel.addProductToCart(products[index]);
//                             //update total
//                             discountModule.applyDiscount(productViewModel.userCart, discountModule.campaignApply);
//                           });
//                         },
//                         child: Stack(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage(products[index].image),
//                                 ),
//                               ),
//                             ),
//                             Positioned.fill(
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Container(
//                                   color: Colors.black54,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child: Text("${products[index].name} ${products[index].price}",
//                                         style: style1),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Expanded(
//                     //Campaign Select
//                     flex: 4,
//                     child: Column(
//                       children: [
//                         SizedBox(
//                                 height: 10,
//                               ),
//                         Text(discountTypeTitle(DiscountType.coupon)),
//                         Divider(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const SizedBox(height: 10.0),
//                             Wrap(
//                               spacing: 15.0,
//                               children: List<Widget>.generate(
//                                 2,
//                                 (int index) {
//                                   return ChoiceChip(
//                                     label: index == 0
//                                         ? Text("Fix amount")
//                                         : Text("Percentage discount"),
//                                     selected: _selectedCouponType == index,
//                                     onSelected: (bool selected) {
//                                       setState(() {
//                                         if(_selectedCouponType == index) {
//                                           _selectedCouponType = null;
//                                           discountModule.campaignApply.clear();
//                                           discountModule.applyDiscount(productViewModel.userCart, discountModule.campaignApply);
//                                         } else {
//                                           _selectedCouponType = index;
//                                         }
//                                       });
//                                     },
//                                   );
//                                 },
//                               ).toList(),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Visibility(
//                           visible: _selectedCouponType == 0,
//                           child: TextField(
//                             controller:  _fixAmountController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Enter Fix Amount',
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: _selectedCouponType == 1,
//                           child: TextField(
//                             controller:  _percentageDiscountController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Enter Percentage Amount',
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                                 height: 10,
//                               ),
//                         Text("On-Top campaign"),
//                         Divider(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const SizedBox(height: 10.0),
//                             Wrap(
//                               spacing: 15.0,
//                               children: List<Widget>.generate(
//                                 2,
//                                 (int index) {
//                                   return ChoiceChip(
//                                     label: index == 0
//                                         ? Text("% discount by category")
//                                         : Text("Discount by points"),
//                                     selected: _selectedOnTopType == index,
//                                     onSelected: (bool selected) {
//                                       setState(() {
//                                         if(_selectedOnTopType == index) {
//                                           _selectedOnTopType = null;
//                                           discountModule.campaignApply.clear();
//                                           discountModule.applyDiscount(productViewModel.userCart, discountModule.campaignApply);
//                                         } else {
//                                           _selectedOnTopType = index;
//                                         }
                                      
//                                       });
//                                     },
//                                   );
//                                 },
//                               ).toList(),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Visibility(
//                           visible: _selectedOnTopType == 0,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               DropdownButton(
//                                   value: _selectedCategoryForDiscount, //selected option
//                                   icon: Icon(Icons.arrow_downward_rounded),
//                                   onChanged: ( newVal) {
//                                     setState(() {
//                                       _selectedCategoryForDiscount = newVal ; // Set a default value if newVal is null
//                                     });
//                                   },
//                                   items: [
//                                     //FIXME: ProductCategory
//                                     DropdownMenuItem<ProductCategory>(
//                                       value: null,
//                                       child: Text('Select the category'),
//                                     ),
//                                     for (ProductCategory category in ProductCategory.values)
//                                       DropdownMenuItem<ProductCategory>(
//                                         value: category,
//                                         child: Text(categoryTitle(category)),
//                                       ),
//                                   ],
//                               ),
//                               SizedBox(
//                                 width: 30,
//                               ),
//                               SizedBox(
//                                 width: 150,
//                                 child: TextField(
//                                   controller: _percentageDiscountAmountController,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     labelText: 'Enter Amount',
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 10,),
//                         Visibility(
//                           visible: _selectedOnTopType == 1,
//                           child: TextField(
//                             controller: _customerPointController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Enter Customer points',
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                                 height: 10,
//                               ),
//                         Text("Seasonal campaign"),
//                         Divider(),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const SizedBox(height: 10.0),
//                             Wrap(
//                               spacing: 15.0,
//                               children: List<Widget>.generate(
//                                 1,
//                                 (int index) {
//                                   return ChoiceChip(
//                                     label: Text("Special campaigns"),
//                                     selected: _selectedSeasonalType == index,
//                                     onSelected: (bool selected) {
//                                       setState(() {
//                                          if(_selectedSeasonalType == index) {
//                                           _selectedSeasonalType = null;
//                                           discountModule.campaignApply.clear();
//                                           discountModule.applyDiscount(productViewModel.userCart, discountModule.campaignApply);
//                                         } else {
//                                           _selectedSeasonalType = index;
//                                         }
//                                       });
//                                     },
//                                   );
//                                 },
//                               ).toList(),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 10,),
//                         Visibility(
//                           visible: _selectedSeasonalType == 0,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 150,
//                                 child: TextField(
//                                   controller: _specialCampaignThresholdController,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     //FIXME:
//                                     labelText: 'Enter Campaign Threshold',
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               SizedBox(
//                                 width: 150,
//                                 child: TextField(
//                                   controller: _specialCampaignFixedDiscountController,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     //FIXME:
//                                     labelText: 'Enter Discount',
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     )),
  
//                    OutlinedButton(
//                       style: OutlinedButton.styleFrom(
                    
//                         primary: Colors.white,
//                         backgroundColor: Colors.blue,
//                       ),
//                       child: const Text('apply discount'),
//                       onPressed: () {
//                         print("button work");
//                         discountModule.campaignApply.clear();
//                         //FIXME: separate function
//                         if (_selectedCouponType == 0 ){
//                           try {
//                             double value = double.parse(_fixAmountController.text);
//                             //FIXME:
//                             discountModule.campaignApply.add(Discount(type: DiscountType.coupon, subType: SubDiscountType.fixed, value: value, apply: true));

//                           } catch (e) {
//                             print('Invalid input: ${_fixAmountController.text}');
//                           }
//                         }
//                         else if (_selectedCouponType == 1 ){
//                           try {
//                             double value = double.parse(_percentageDiscountController.text);
//                             //FIXME:
//                             discountModule.campaignApply.add(Discount(type: DiscountType.coupon, subType: SubDiscountType.percentage, value: value, apply: true));

//                           } catch (e) {
//                             print('Invalid input: ${_percentageDiscountController.text}');
//                           }
//                         }
//                         if (_selectedOnTopType == 0 ){
//                           try {
//                             //ProductCategory category= _selectedCategoryForDiscount;
//                             double percentage = double.parse(_percentageDiscountAmountController.text);
//                             //FIXME:
//                             discountModule.campaignApply.add(Discount(type: DiscountType.onTop, subType: SubDiscountType.percentageByCategory, value: {'category':_selectedCategoryForDiscount, 'amount':percentage}, apply: true));
//                           } catch (e) {
//                             print('Invalid input: ${_percentageDiscountAmountController.text}');
//                             print('Invalid input: ${_selectedCategoryForDiscount}');

//                           }
                         
//                         }
//                         else if (_selectedOnTopType == 1 ){
//                           try {
//                           double  value = double.parse(_customerPointController.text);
//                           discountModule.campaignApply.add(Discount(type: DiscountType.onTop, subType: SubDiscountType.points, value: value, apply: true));
//                           } catch (e) {
//                             print('Invalid input: ${_customerPointController.text}');
//                           }
//                         }

//                         if (_selectedSeasonalType == 0 ){
//                           try {
//                           double x = double.parse(_specialCampaignThresholdController.text);
//                           double y = double.parse(_specialCampaignFixedDiscountController.text);
//                           if (x>y){
//                             discountModule.campaignApply.add(Discount(type: DiscountType.seasonal, subType: SubDiscountType.special, value: {'specialCampaignThreshold': x  ,'specialCampaignFixedDiscount':y}, apply: true));

//                             //discounts.add(Discount(type: 'SpecialCampaigns', value: {'everyX': x  ,'discountY':y}, apply: true));
//                           }
//                           else {
//                             //CustomAlertDialog(content: 'test',title: "test2");
//                           }
//                           } catch (e) {
//                             print('Invalid input: ${_specialCampaignThresholdController.text}');
//                             print('Invalid input: ${_specialCampaignFixedDiscountController.text}');
//                           }
//                         }
//                         discountModule.applyDiscount(productViewModel.userCart, discountModule.campaignApply);
//                         setState(() {
//                         });
//                         //print(discounts);
//                       },
//                     )
//               ],
//             ),
//           ),
//           Expanded( // right part
//               flex: 1,
//               child: Column( 
//                 children: [
//                   Expanded(
//                       flex: 1,
//                       child: Row( // label of cart
//                         children: [
//                           Expanded(
//                               flex: 1,
//                               child: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Add/Remove"))),
//                           Expanded(
//                               // name column
//                               flex: 1,
//                               child: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Name"))),
//                           Expanded(
//                               // description column
//                               flex: 1,
//                               child: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Category"))),
//                           Expanded(
//                               // description column
//                               flex: 1,
//                               child: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Qty"))),       
//                           Expanded(
//                               // item total column
//                               flex: 1,
//                               child: Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Amount")))
//                         ],
//                       )),
//                   const Divider(
//                     // line below header
//                     height: 20,
//                     thickness: 1,
//                     indent: 20,
//                     endIndent: 0,
//                     color: Colors.black,
//                   ),
//                   Expanded(
//                       flex: 8,
//                       child: ListView.builder( // item in cart
//                         itemCount: productViewModel.userCart.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           String column3 =
//                               (productViewModel.userCart[index].price * productViewModel.userCart[index].qty).toString();
//                           return Row(
//                             children: [
//                               Expanded(
//                                   flex: 1,
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                               // add or remove button column
//                                               flex: 1,
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: MaterialButton(
//                                                       color: Colors.black54,
//                                                       shape: CircleBorder(),
//                                                       child: Icon(
//                                                         Icons.add,
//                                                         color: Colors.green,
//                                                       ),
//                                                       onPressed: () {
//                                                         // do something
//                                                         setState(() {
//                                                           productViewModel.addProductToCart(
//                                                               productViewModel.userCart[index]);
//                                                          // discountModule.applyDiscount(productViewModel.cart, discounts);
//                                                         }
//                                                         );
//                                                       },
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: MaterialButton(
//                                                       onPressed: () {
//                                                         setState(() {
//                                                           productViewModel.removeFromCart(
//                                                               productViewModel.userCart[index]);
//                                                           //discountModule.applyDiscount(productViewModel.cart, discounts);
//                                                         });
//                                                       },
//                                                       color: Colors.black54,
//                                                       shape: CircleBorder(),
//                                                       child: Icon(
//                                                         Icons.remove,
//                                                         color: Colors.red,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )),
//                                           Expanded(
//                                               // name column
//                                               flex: 1,
//                                               child: Container(
//                                                   alignment: Alignment.center,
//                                                   child:
//                                                       Text(productViewModel.userCart[index].name))),
//                                           Expanded(
//                                               // description column
//                                               flex: 1,
//                                               child: Container(
//                                                   alignment: Alignment.center,
//                                                   child: Text(productViewModel.userCart[index].category.toString()))),
//                                            Expanded(
//                                               // description column
//                                               flex: 1,
//                                               child: Container(
//                                                   alignment: Alignment.center,
//                                                   child: Text("${productViewModel.userCart[index].qty.toString()}"))),
//                                           Expanded(
//                                               // item total column
//                                               flex: 1,
//                                               child: Container(
//                                                   alignment: Alignment.center,
//                                                   child: Text(column3))),
//                                         ],
//                                       ),
//                                       const Divider(
//                                         // line below head
//                                         height: 20,
//                                         thickness: 1,
//                                         indent: 20,
//                                         endIndent: 0,
//                                         color: Colors.black54,
//                                       ),
//                                     ],
//                                   ))
//                             ],
//                           );
//                         },
//                       )),
//                       Divider(color: Colors.black45,),
//                       Expanded(flex :1 , child: Text("Sub total ${productViewModel.calculateGrandTotal(productViewModel.userCart)}")),
//                   Visibility( //discount part
//                     visible: discountModule.campaignApply.isNotEmpty,
//                     child: Expanded(
//                       flex: 1,
//                       child: 
//                           ListView.builder(
//                             itemCount: discountModule.campaignApply.length, 
//                             itemBuilder: (BuildContext context, int index) {
//                               return Row(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text("${discountModule.campaignApply[index].type} discount ${discountModule.getDiscountInfo(discountModule.campaignApply[index])} THB"),
//                                       Text("${discountModule.campaignApply[index].value}"),
//                                       Text("${discountModule.getDiscountInfo(discountModule.campaignApply[index])}"),
//                                     ],
//                                   ),
//                                   //Text("${discountModule.campaignApply[index].type} every ${discountModule.campaignApply[index].value['everyX']} THB discount ${discountModule.campaignApply[index].value['discountY']} THB "),
//                                 ],
//                               );
//                             },
//                           )


//                     ),
//                   ),
//                   const Divider(
//                     // line below head
//                     height: 20,
//                     thickness: 1,
//                     indent: 20,
//                     endIndent: 0,
//                     color: Colors.black,
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Text("Total: ${discountModule.totalPriceAfterDiscount}"),
//                   )
//                 ],
//               ))
//         ],
//       ),
//     );
//   }

// } //ec


// TextStyle style1 = TextStyle(fontSize: 20, color: Colors.white60);
