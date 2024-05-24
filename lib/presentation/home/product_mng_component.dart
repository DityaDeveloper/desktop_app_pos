import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import 'package:desktop_app_pos/model/static_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controller/product_mng_component.dart';
import 'home.dart';

GetStorage box = GetStorage();

class ProductManagementComponent extends StatefulWidget {
  const ProductManagementComponent({super.key});

  @override
  State<ProductManagementComponent> createState() =>
      _ProductManagementComponentState();
}

class _ProductManagementComponentState
    extends State<ProductManagementComponent> {
  TextEditingController productNameCtr = TextEditingController();
  TextEditingController productQtyCtr = TextEditingController();
  TextEditingController productPriceCtr = TextEditingController();

  int count = 0;
  List<StaticModel> ctx = [];

  @override
  void initState() {
    super.initState();
    //getdbProduct();
    getProducts();
  }

  storeProducts() async {
    var paymentsAsMap = ctx.map((payment) => payment.toJson()).toList();
    String jsonString = jsonEncode(paymentsAsMap);
    await box.write('products', jsonString);
    debugPrint('success add : $paymentsAsMap');
    setState(() {
      dataSource = ProductDataTable(ctx);
    });
  }

  sendProducts(StaticModel products) async {
    Uri url = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/product.json");
    await http.post(url,
        body: jsonEncode({
          "id": products.id,
          "name": products.name,
          "price": products.price,
          "qty": products.qty,
          "unit": products.unit,
        }));
    getProducts();
  }

  getProducts() async {
    Uri url = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/product.json");
    final response = await http.get(url);

    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    ctx.clear();
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
      dataSource = ProductDataTable(ctx);
      controller.isupdateTable.value = false;
    });
  }

  getdbProduct() {
    var result = box.read('products');
    List<dynamic> templist = [];
    if (result == null) {
      debugPrint('is null');
      ctx = [];
    } else {
      debugPrint('is not null');
      dynamic jsonData = jsonDecode(result);
      setState(() {
        templist =
            jsonData.map((object) => StaticModel.fromJson(object)).toList() ??
                [];
        ctx = templist.cast<StaticModel>();
        dataSource = ProductDataTable(ctx);
        controller.isupdateTable.value = false;
      });
    }
  }

  ProductDataTable dataSource = ProductDataTable([]);

  String chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  math.Random rnd = math.Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

  final controller = Get.put(ProductManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Data Produk', style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(
            width: double.infinity,
            height: 370,
            child: PaginatedDataTable(
              source: dataSource,
              arrowHeadColor: Colors.blue,
              onPageChanged: (value) => count,
              columnSpacing: 5,
              horizontalMargin: 5,
              rowsPerPage: 5,
              showCheckboxColumn: false,
              //minWidth: 700,
              columns: const [
                DataColumn(
                  label: SizedBox(
                      width: 100,
                      child: Text(
                        "ID",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                DataColumn(
                  label: SizedBox(
                      width: 100,
                      child: Text(
                        "Nama Pakaian",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                DataColumn(
                  label: SizedBox(
                      width: 100,
                      child: Text(
                        "Jumlah",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                DataColumn(
                  label: SizedBox(
                      width: 100,
                      child: Text(
                        "Harga",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                DataColumn(
                  label: SizedBox(
                      width: 100,
                      child: Text(
                        "Aksi",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFF05A22),
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: productNameCtr,
                              onChanged: (value) => productNameCtr.text,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Masukan nama pakaian',
                              ),
                            ),
                            TextFormField(
                              controller: productPriceCtr,
                              onChanged: (value) => productPriceCtr.text,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Masukan harga pakaian',
                              ),
                            ),
                            TextFormField(
                              controller: productQtyCtr,
                              onChanged: (value) => productQtyCtr.text,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Masukan jumlah pakaian',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * .4,
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: TextButton(
                              onPressed: () {
                                String id = getRandomString(5);
                                String name = productNameCtr.text;
                                int price = int.parse(productPriceCtr.text);
                                int qty = int.parse(productQtyCtr.text);
                                
                                setState(() {
                                  productNameCtr.clear();
                                  productPriceCtr.clear();
                                  productQtyCtr.clear();
                                });

                                sendProducts(StaticModel(
                                    ref: '',
                                    id: id,
                                    name: name,
                                    qty: qty,
                                    unit: 'pcs',
                                    price: price));
                                //storeProducts();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.teal,
                              ),
                              child: const Text('Simpan'),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: TextButton(
                              onPressed: () => Get.to(const Home()),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.redAccent,
                              ),
                              child: const Text('Kembali'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProductDataTable extends DataTableSource {
  List<StaticModel> ctx;

  ProductDataTable(this.ctx) {
    //print(dataList);
  }
  // Generate some made-up data

  storeProducts(List<StaticModel> data) async {
    var paymentsAsMap = data.map((payment) => payment.toJson()).toList();
    String jsonString = jsonEncode(paymentsAsMap);
    await box.write('products', jsonString);
    debugPrint('success add : $paymentsAsMap');
  }

  getdbProduct() {
    var result = box.read('products');
    List<dynamic> templist = [];
    if (result == null) {
      debugPrint('is null');
      ctx = [];
    } else {
      debugPrint('is not null');

      dynamic jsonData = jsonDecode(result);
      templist =
          jsonData.map((object) => StaticModel.fromJson(object)).toList() ?? [];
      ctx = templist.cast<StaticModel>();
    }
  }

  @override
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => ctx.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    var data = ctx[index];
    return DataRow(
      cells: [
        DataCell(
          Text(
            data.id.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(
          Text(
            data.name,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(Text(data.qty.toString())),
        DataCell(Text(data.price.toString())),
        DataCell(InkWell(
            onTap: () {
              ctx.remove(data);
              debugPrint('success delete $data');
              debugPrint('$ctx');
              notifyListeners();
              storeProducts(ctx);
              getdbProduct();
            },
            child: const Icon(Icons.delete, color: Colors.red))),
      ],
    );
  }
}
