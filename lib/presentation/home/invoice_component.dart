import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import 'package:desktop_app_pos/model/static_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controller/product_mng_component.dart';
import '../../model/product/order_model.dart';
import 'home.dart';

GetStorage box = GetStorage();

class InvoiceComponent extends StatefulWidget {
  const InvoiceComponent({super.key});

  @override
  State<InvoiceComponent> createState() => _InvoiceComponentState();
}

class _InvoiceComponentState extends State<InvoiceComponent> {
  TextEditingController productNameCtr = TextEditingController();
  TextEditingController productQtyCtr = TextEditingController();
  TextEditingController productPriceCtr = TextEditingController();

  int count = 0;
  List<OrderModel> ctx = [];

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
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/orderproduct.json");
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
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/orderproduct.json");
    final response = await http.get(url);

    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    ctx.clear();
    extractedData.forEach((profileId, profileData) {
      ctx.add(
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
        ctx = templist.cast<OrderModel>();
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
          const Text('Data Transaksi', style: TextStyle(fontWeight: FontWeight.bold),),
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
                        "ID Transaksi",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                DataColumn(
                  label: SizedBox(
                      width: 100,
                      child: Text(
                        "Tanggal",
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
                        "Pembelian",
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
    );
  }
}

class ProductDataTable extends DataTableSource {
  List<OrderModel> ctx;

  ProductDataTable(this.ctx) {
    //print(dataList);
  }
  // Generate some made-up data

  storeProducts(List<OrderModel> data) async {
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
          jsonData.map((object) => OrderModel.fromJson(object)).toList() ?? [];
      ctx = templist.cast<OrderModel>();
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
            data.ref.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(
          Text(
            data.createdAt,
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
