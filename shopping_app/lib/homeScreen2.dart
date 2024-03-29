import 'package:flutter/material.dart';
import 'package:shopping_app/models/discount.dart';
import 'package:shopping_app/style.dart';
import 'package:shopping_app/viewModels/productViewModel.dart';
import 'package:shopping_app/widgets/cartCard.dart';
import 'viewModels/discountViewModel.dart';
import 'models/product.dart';
import 'widgets/productCard.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int? _selectedCouponType;
  int? _selectedOnTopType;
  int? _selectedSeasonalType;
  final TextEditingController _fixAmountController = TextEditingController();
  final TextEditingController _percentageDiscountController = TextEditingController();
  ProductCategory? _selectedCategoryForDiscount;
  final TextEditingController _percentageDiscountAmountController = TextEditingController();
  final TextEditingController _customerPointController = TextEditingController();
  final TextEditingController _specialCampaignThresholdController = TextEditingController();
  final TextEditingController _specialCampaignFixedDiscountController = TextEditingController();

  late ProductViewModel productViewModel;
  late DiscountViewModel discountModule;

  @override
  void initState() {
    super.initState();
    productViewModel = ProductViewModel();
    discountModule = DiscountViewModel();
  }
  
  void refreshPage(){
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar
      appBar: AppBar(title: const Text("Shopping App"), actions: [], backgroundColor: Colors.black,),
      //body
      body: Row(
        children: [
          Expanded( //left part
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded( //Product Grid
                    flex: 2,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0, //x spacing
                        mainAxisSpacing: 4.0, //y spacing
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          onTap: (){
                            productViewModel.addProductToCart(products[index]);
                            discountModule.applyDiscount(productViewModel.userCart,  discountModule.campaignApply);
                            refreshPage();
                          }, 
                          productName: products[index].name, 
                          productCategory: products[index].category, 
                          productImage: products[index].image, 
                          productPrice: products[index].price);
                     },
                    ),
                  ),
                     Expanded( //Campaign Select
                          flex: 3,
                          child: Column(
                            children: [
                              SizedBox(
                                      height: 10,
                                    ),
                              Text(DiscountType.coupon.title),
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
                                          selected: _selectedCouponType == index,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              if(_selectedCouponType == index) {
                                                _selectedCouponType = null;
                                                discountModule.removeDiscountByType(DiscountType.coupon);
                                                discountModule.applyDiscount(productViewModel.userCart, discountModule.campaignApply);
                                                setState(() {
                                                });
                                              } else {
                                                _selectedCouponType = index;
                                                discountModule.removeDiscountByType(DiscountType.coupon);
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
                              if (_selectedCouponType == 0)
                                SizedBox(
                                  width: 400,
                                  child: TextField(
                                    controller: _fixAmountController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Fix Amount',
                                    ),
                                                            ),
                                )
                              else if (_selectedCouponType == 1)
                                SizedBox(
                                  width: 400,
                                  child: TextField(
                                    controller: _percentageDiscountController,
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
                                          selected: _selectedOnTopType == index,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              if(_selectedOnTopType == index) {
                                                _selectedOnTopType = null;
                                                discountModule.removeDiscountByType(DiscountType.onTop);
                                                discountModule.applyDiscount(productViewModel.userCart, discountModule.campaignApply);
                                              } else {
                                                _selectedOnTopType = index;
                                                discountModule.removeDiscountByType(DiscountType.onTop);
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
                              if (_selectedOnTopType == 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DropdownButton(
                                  value: _selectedCategoryForDiscount,
                                  icon: Icon(Icons.arrow_downward_rounded),
                                  onChanged: (newVal) {
                                    setState(() {
                                      _selectedCategoryForDiscount = newVal;
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem<ProductCategory>(
                                      value: null,
                                      child: Text('Select the category'),
                                    ),
                                    for (ProductCategory category in ProductCategory.values)
                                      DropdownMenuItem<ProductCategory>(
                                        value: category,
                                        child: Text(category.title),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                SizedBox(
                                  width: 300,
                                  child: TextField(
                                    controller: _percentageDiscountAmountController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Amount of Percentage',
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else if (_selectedOnTopType == 1)
                            SizedBox(
                              width: 400,
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
                                          selected: _selectedSeasonalType == index,
                                          onSelected: (bool selected) {
                                            setState(() {
                                               if(_selectedSeasonalType == index) {
                                                _selectedSeasonalType = null;
                                                discountModule.removeDiscountByType(DiscountType.seasonal);
                                                discountModule.applyDiscount(productViewModel.userCart, discountModule.campaignApply);
                                              } else {
                                                _selectedSeasonalType = index;
                                                discountModule.removeDiscountByType(DiscountType.seasonal);
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
                              if (_selectedSeasonalType == 0)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: TextField(
                                        controller: _specialCampaignThresholdController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter Campaign Threshold',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 300,
                                      child: TextField(
                                        controller: _specialCampaignFixedDiscountController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Enter Discount',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                  
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Color.fromARGB(157, 0, 0, 0),
                          ),
                          child: const Text('Apply Discount'),
                          onPressed: () {
                            discountModule.campaignApply.clear();
                            //FIXME: separate function
                            if (_selectedCouponType == 0 ){
                              try {
                                double value = double.parse(_fixAmountController.text);
                                //FIXME:
                                discountModule.campaignApply.add(Discount(type: DiscountType.coupon, subType: SubDiscountType.fixed, value: value, apply: true));
              
                              } catch (e) {
                                print('Invalid input: ${_fixAmountController.text}');
                              }
                            }
                            else if (_selectedCouponType == 1 ){
                              try {
                                double value = double.parse(_percentageDiscountController.text);
                                //FIXME:
                                discountModule.campaignApply.add(Discount(type: DiscountType.coupon, subType: SubDiscountType.percentage, value: value, apply: true));
              
                              } catch (e) {
                                print('Invalid input: ${_percentageDiscountController.text}');
                              }
                            }
                            if (_selectedOnTopType == 0 ){
                              try {
                                if(_selectedCategoryForDiscount != null){
                                   double percentage = double.parse(_percentageDiscountAmountController.text);
                                //FIXME:
                                discountModule.campaignApply.add(Discount(type: DiscountType.onTop, subType: SubDiscountType.percentageByCategory, value: {SpecialDiscountValue.category:_selectedCategoryForDiscount, SpecialDiscountValue.amount:percentage}, apply: true));
                                }
                              } catch (e) {
                                print('Invalid input: ${_percentageDiscountAmountController.text}');
                                print('Invalid input: ${_selectedCategoryForDiscount}');
              
                              }
                             
                            }
                            else if (_selectedOnTopType == 1 ){
                              try {
                              double  value = double.parse(_customerPointController.text);
                              discountModule.campaignApply.add(Discount(type: DiscountType.onTop, subType: SubDiscountType.points, value: value, apply: true));
                              } catch (e) {
                                print('Invalid input: ${_customerPointController.text}');
                              }
                            }
              
                            if (_selectedSeasonalType == 0 ){
                              try {
                              double x = double.parse(_specialCampaignThresholdController.text);
                              double y = double.parse(_specialCampaignFixedDiscountController.text);
                              if (x>y){
                                discountModule.campaignApply.add(Discount(type: DiscountType.seasonal, subType: SubDiscountType.special, value: {SpecialDiscountValue.specialCampaignThreshold: x  , SpecialDiscountValue.specialCampaignFixedDiscount:y}, apply: true));              
                              }

                              } catch (e) {
                                print('Invalid input: ${_specialCampaignThresholdController.text}');
                                print('Invalid input: ${_specialCampaignFixedDiscountController.text}');
                              }
                            }
                            discountModule.applyDiscount(productViewModel.userCart, discountModule.campaignApply);
                            setState(() {
                            });
                          },
                        )
                  
                  ],
              ),
            ),
          ),
          Expanded( // right part
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("MY CART",textAlign: TextAlign.start, style: myCart),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        flex: 8,
                        child: ListView.builder( // item in cart
                          itemCount: productViewModel.userCart.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CartCard(
                                    productName: productViewModel.userCart[index].name, 
                                    category: productViewModel.userCart[index].category, 
                                    price: (productViewModel.userCart[index].price *productViewModel.userCart[index].qty), 
                                    qty: productViewModel.userCart[index].qty, 
                                    image: productViewModel.userCart[index].image,
                                    onTapAdd: () {
                                       productViewModel.addProductToCart(productViewModel.userCart[index]);
                                       discountModule.applyDiscount(productViewModel.userCart,  discountModule.campaignApply);
                                       refreshPage();
                                    },
                                    onTapRemove: () {
                                      productViewModel.removeFromCart( productViewModel.userCart[index]);
                                      discountModule.applyDiscount(productViewModel.userCart,  discountModule.campaignApply);
                                      refreshPage();
                                    },
                                    );
                          },
                        )),
                        Divider(color: Colors.black45,),
                        Expanded(flex :1 , child: Text("Sub total ${productViewModel.calculateGrandTotal(productViewModel.userCart)} THB")),
                    Visibility( //discount part
                      visible: discountModule.campaignApply.isNotEmpty,
                      child: Expanded(
                        flex: 1,
                        child: 
                            ListView.builder(
                              itemCount: discountModule.campaignApply.length, 
                              itemBuilder: (BuildContext context, int index) {
                                String discountText = '';
                                switch (discountModule.campaignApply[index].subType) {
                                case SubDiscountType.fixed:
                                  discountText = 'Fixed discount ${discountModule.getDiscountInfo(discountModule.campaignApply[index])} THB';
                                  break;
                                case SubDiscountType.percentage:
                                  discountText = 'Percentage discount ${discountModule.getDiscountInfo(discountModule.campaignApply[index])} THB';
                                  break;
                                case SubDiscountType.percentageByCategory:
                                  discountText = '${discountModule.campaignApply[index].value[SpecialDiscountValue.amount]}% off on ${discountModule.campaignApply[index].value[SpecialDiscountValue.category].title} discount ${discountModule.getDiscountInfo(discountModule.campaignApply[index])} THB';
                                  break;
                                case SubDiscountType.points:
                                  discountText = 'Points: ${discountModule.campaignApply[index].value} discount: ${discountModule.getDiscountInfo(discountModule.campaignApply[index])} THB';
                                  break;
                                case SubDiscountType.special:
                                  discountText = 'Discount ${discountModule.campaignApply[index].value[SpecialDiscountValue.specialCampaignThreshold]} THB at every ${discountModule.campaignApply[index].value[SpecialDiscountValue.specialCampaignFixedDiscount]} discount ${discountModule.getDiscountInfo(discountModule.campaignApply[index])} THB';
                                }
                                return Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text(discountText),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            )
                      ),
                    ),
                    const Divider(
                      // line below head
                      // height: 20,
                      // thickness: 1,
                      // indent: 20,
                      // endIndent: 0,
                       color: Colors.black,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("Total: ${discountModule.totalPriceAfterDiscount} THB"),
                    )
                  ],
                ),
              )
            )
        ],
      ),
    );
  }

} //ec



