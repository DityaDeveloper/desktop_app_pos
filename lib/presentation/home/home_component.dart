import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

import '../../model/product/order_model.dart';
import '../../model/static_model.dart';
import '../login/login.dart';
import 'ahp.dart';
import 'ahp_alternatif_component.dart';
import 'ahp_kriteria_component.dart';
import 'product_mng_component.dart';
import 'invoice_component.dart';
import 'user_mng_component.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({super.key});

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent> {
  GetStorage box = GetStorage();

  TextEditingController searchCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    box.remove('products');
    box.remove('orders');
    getDb();
  }

  List<StaticModel> ctx = [];

  List<OrderModel> orderlist = [];
  List<StaticModel> searchableList = [];
  List<StaticModel> searchableLocalList = [];

  Map<String, dynamic>? userorder;

  bool isfiltered = false;
  bool isorder = false;

  int amount = 0;
  int totalProduct = 0;
  int totalBalance = 0;
  int productIndex = 0;
  int productSellingAmout = 0;

  storeDb() async {
    // await storeOrders();
    await storeProducts();
  }

  getDb() {
    getdbOrders();
    getdbProduct();
    sumDashboard();
  }

  storeOrders(StaticModel products, String ref, int amount) async {
    Uri urlUpdateProduct = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/product/$ref.json");
    Uri urlOrderProduct = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/orderproduct.json");
    //await http.delete(url);
    DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    await http.post(urlOrderProduct,
        body: jsonEncode({
          "id": products.id,
          "name": products.name,
          "price": products.price * amount,
          "qty": amount,
          "unit": products.unit,
           "createdAt": formattedDate,
        }));
    await http.patch(urlUpdateProduct,
        body: jsonEncode({
          "id": products.id,
          "name": products.name,
          "price": products.price,
          "qty": products.qty,
          "unit": products.unit,
         
        }));
    debugPrint('ref : $urlUpdateProduct');
    debugPrint('produk qty : ${products.qty}');
    ctx.clear();
    getDb();
    sumDashboard();
  }

  storeProducts() async {
    var paymentsAsMap = ctx.map((payment) => payment.toJson()).toList();
    String jsonString = jsonEncode(paymentsAsMap);
    await box.write('products', jsonString);
    sumDashboard();
  }

  getdbOrders() async {
    Uri url = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/orderproduct.json");
    final response = await http.get(url);

    if (response.body == 'null') {
      debugPrint('is null');
      orderlist = [];
    } else {
      debugPrint('is product not null');
      //ctx.clear();
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((profileId, profileData) {
        orderlist.add(
          OrderModel(
            ref: profileId,
            id: profileData['id'],
            name: profileData['name'],
            unit: profileData['unit'],
            price: profileData['price'],
            qty: profileData['qty'],
            createdAt: profileData['createdAt'],
          ),
        );
      });
      setState(() {
        orderlist;
        totalBalance = orderlist.fold(0, (sum, item) => sum + item.price);
      });
    }
  }

  getdbProduct() async {
    Uri url = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/product.json");
    final response = await http.get(url);

    if (response.body.isEmpty) {
      debugPrint('is null');
      ctx = [];
    } else {
      debugPrint('is product not null');
      //ctx.clear();
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((profileId, profileData) {
        ctx.add(
          StaticModel(
            ref: profileId,
            id: profileData['id'],
            name: profileData['name'],
            unit: profileData['unit'],
            price: profileData['price'],
            qty: profileData['qty'],
          ),
        );
      });
      setState(() {
        ctx;
        totalProduct = ctx.length;
      });
    }
  }

  void filterSearchResults(String query) {
    setState(() {
      searchableList = ctx;
      ctx = ctx
          .where((item) =>
              item.name.toLowerCase().contains(query.toLowerCase()) ||
              item.id.toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void sumDashboard() {
    totalProduct = ctx.length;
    totalBalance = orderlist.fold(0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    double bodywidth = Get.width * .8;
    return SizedBox(
      child: Row(
        children: [
          Container(
            color: const Color.fromARGB(255, 199, 206, 210),
            width: Get.width * .2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      SizedBox(
                        child: GFTypography(
                          text: 'APLIKASI POS ku',
                          textColor: Colors.blueAccent,
                          dividerColor: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(
                        child: GFTypography(
                            text: 'prayogi@owner.xyz',
                            textColor: Colors.blueAccent,
                            dividerColor: Colors.blueAccent,
                            showDivider: false,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        child: GFTypography(
                            text: 'ADMIN',
                            type: GFTypographyType.typo5,
                            textColor: Colors.blueAccent,
                            dividerColor: Colors.blueAccent,
                            showDivider: false,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GFButton(
                      onPressed: () => Get.to(const LoginScreen()),
                      text: "Keluar",
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      size: GFSize.SMALL,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black45,
            width: Get.width * .8,
            child: Column(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: GFTypography(
                            text: 'Menu',
                            textColor: Colors.white,
                            dividerColor: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * .8,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 200,
                              child: GFButton(
                                onPressed: () {
                                  if (isorder == false) {
                                    setState(() {
                                      isorder = true;
                                    });
                                  } else {
                                    setState(() {
                                      isorder = false;
                                    });
                                  }
                                },
                                text: "tambah pesanan",
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                icon: const Icon(
                                  Icons.request_quote,
                                  color: Colors.white,
                                ),
                                size: GFSize.SMALL,
                                color: Colors.blueAccent,
                              ),
                            ),
                            SizedBox(
                              width: 410,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: GFButton(
                                        onPressed: () => Get.to(
                                         // const AhpAlternatifDataComponent()
                                         // const AhpKriteriaDataComponent()
                                         const AhpComponent()
                                          ),
                                      // onPressed: () => Get.snackbar(
                                      //     'Pemberitahuan',
                                      //     'Fitur ini sedang dalam pengembangan'),
                                      text: "SPK",
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      icon: const Icon(
                                        Icons.verified,
                                        color: Colors.white,
                                      ),
                                      size: GFSize.SMALL,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: GFButton(
                                      onPressed: () => Get.to(
                                          const UserManagementComponent()),
                                      text: "user",
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      icon: const Icon(
                                        Icons.verified_user_outlined,
                                        color: Colors.white,
                                      ),
                                      size: GFSize.SMALL,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: GFButton(
                                      onPressed: () => Get.to(
                                          const ProductManagementComponent()),
                                      text: "produk",
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      icon: const Icon(
                                        Icons.production_quantity_limits,
                                        color: Colors.white,
                                      ),
                                      size: GFSize.SMALL,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: GFButton(
                                      onPressed: () =>
                                          Get.to(const InvoiceComponent()),
                                      text: "invoice",
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      icon: const Icon(
                                        Icons.inventory_2,
                                        color: Colors.white,
                                      ),
                                      size: GFSize.SMALL,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: GFTypography(
                            text: 'Data Barang',
                            textColor: Colors.white,
                            dividerColor: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: bodywidth,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 2, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 200,
                              child: GFButton(
                                onPressed: () {},
                                text: "Balance : Rp. $totalBalance",
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: GFButton(
                                onPressed: () {},
                                text: "Total Unit : $totalProduct",
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              child: AnimSearchBar(
                                helpText: "masukan nama atau id pakaian",
                                width: 250,
                                textController: searchCtr,
                                onSuffixTap: () {
                                  setState(() {
                                    searchCtr.clear();
                                  });
                                },
                                onSubmitted: (value) {
                                  if (value.isNotEmpty) {
                                    filterSearchResults(value);
                                    setState(() {
                                      isfiltered = true;
                                    });
                                  } else {
                                    setState(() {
                                      ctx = searchableList;
                                      isfiltered = false;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: isfiltered == false
                                    ? const SizedBox.shrink()
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            ctx = searchableList;
                                            isfiltered = false;
                                          });
                                        },
                                        child: const Icon(Icons.delete,
                                            color: Colors.white)))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 14),
                        child: Container(
                            width: bodywidth,
                            height: 250,
                            color: Colors.white38,
                            child: GridView.builder(
                                itemCount: ctx.length,
                                scrollDirection: Axis.vertical,
                                // physics: const NeverScrollableScrollPhysics(),
                                // shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1.5,
                                        mainAxisSpacing: 2,
                                        crossAxisCount: 4),
                                itemBuilder: (_, index) {
                                  return InkWell(
                                    //behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      // id, name, unit, qty, price
                                      if (isorder == true) {
                                        setState(() {
                                          userorder = {
                                            'ref': ctx[index].ref,
                                            'id': ctx[index].id,
                                            'name': ctx[index].name,
                                            'qty': ctx[index].qty,
                                            'unit': ctx[index].unit,
                                            'price': ctx[index].price,
                                          };
                                          productIndex = index;
                                        });
                                        debugPrint(userorder.toString());
                                      }
                                    },
                                    child: Card(
                                      child: ClipPath(
                                        clipper: ShapeBorderClipper(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3))),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: SizedBox(
                                                width: 70,
                                                height: 30,
                                                child: Card(
                                                  color: isorder == false
                                                      ? Colors.red
                                                      : Colors.green,
                                                  child: Center(
                                                    child: Text(
                                                      '${ctx[index].qty} ${ctx[index].unit}',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              bottom: 0,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  'Rp. ${ctx[index].price}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.redAccent,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                      color: isorder == false
                                                          ? Colors.red
                                                          : Colors.greenAccent,
                                                      width: 5),
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/baju.png',
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                  Text(
                                                    ctx[index].name,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }))),
                  ],
                ),
                Column(
                  children: [
                    isorder == false
                        ? const SizedBox.shrink()
                        : SizedBox(
                            width: bodywidth,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox.shrink(),
                                  SizedBox(
                                    width: 350,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        userorder == null
                                            ? const SizedBox.shrink()
                                            : Center(
                                                child: Text(
                                                userorder!['name']
                                                    .toString()
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (amount == 0) {
                                                    amount = 0;
                                                  } else {
                                                    amount = amount - 1;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 20,
                                                color: Colors.red,
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                width: 60,
                                                color: Colors.white,
                                                child: Center(
                                                    child: Text(
                                                  amount.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (amount >=
                                                      userorder!['qty']) {
                                                    amount = amount;
                                                  } else {
                                                    amount = amount + 1;
                                                  }
                                                });
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 20,
                                                color: Colors.red,
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // id, name, unit, qty, price, date
                                            DateTime now = DateTime.now();
                                            String currentDate =
                                                DateFormat('kk:mm:ss')
                                                    .format(now);
                                            int userqty = userorder!['qty'];

                                            if (userqty == 0) {
                                            } else {
                                              setState(() {
                                                orderlist.add(OrderModel(
                                                    ref: userorder!['ref'],
                                                    id: userorder!['id'],
                                                    name: userorder!['name'],
                                                    qty: amount,
                                                    unit: userorder!['unit'],
                                                    price: userorder!['price'] * amount,
                                                    createdAt: currentDate));
                                                debugPrint(
                                                    'succes add item : $userorder');
                                                debugPrint(
                                                    'data order user : $orderlist');

                                                int userAmount =
                                                    userqty - amount;
                                                debugPrint(
                                                    'user amount : $userAmount');

                                                ctx[productIndex] = StaticModel(
                                                    ref: userorder!['ref'],
                                                    id: userorder!['id'],
                                                    name: userorder!['name'],
                                                    qty: userAmount,
                                                    unit: userorder!['unit'],
                                                    price: userorder!['price']);
                                                storeOrders(ctx[productIndex],
                                                    userorder!['ref'], amount);
                                                //storeDb();

                                                userAmount = 0;
                                                userorder = null;
                                                isorder = false;
                                                amount = 0;
                                                userorder = null;
                                                debugPrint(
                                                    'succes remove item : $userorder');
                                              });
                                            }
                                          },
                                          child: Container(
                                              height: 20,
                                              width: 100,
                                              color: Colors.red,
                                              child: const Center(
                                                  child: Text(
                                                "Tambah",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    SizedBox(
                      width: bodywidth,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 2),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                orderlist.isNotEmpty
                                    ? Container(
                                        width: Get.width * .4,
                                        color: Colors.white38,
                                        height: 120,
                                        child: ListView.builder(
                                            itemCount: orderlist.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ListTile(
                                                  leading: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          orderlist.remove(
                                                              orderlist[index]);
                                                          storeDb();
                                                        });
                                                      },
                                                      child: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red)),
                                                  trailing: Text(
                                                    orderlist[index]
                                                        .price
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 14),
                                                  ),
                                                  subtitle: Text(
                                                    orderlist[index]
                                                        .createdAt
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 14),
                                                  ),
                                                  title: Text(
                                                      "(x${orderlist[index].qty}) ${orderlist[index].name}"));
                                            }),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
