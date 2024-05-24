import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import 'package:desktop_app_pos/model/static_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controller/product_mng_component.dart';
import '../../model/user/user_model.dart';
import 'home.dart';

GetStorage box = GetStorage();

class UserManagementComponent extends StatefulWidget {
  const UserManagementComponent({super.key});

  @override
  State<UserManagementComponent> createState() =>
      _UserManagementComponentState();
}

class _UserManagementComponentState extends State<UserManagementComponent> {
  TextEditingController productNameCtr = TextEditingController();
  TextEditingController productQtyCtr = TextEditingController();
  TextEditingController productPriceCtr = TextEditingController();

  int count = 0;
  List<UserModel> ctx = [];

  @override
  void initState() {
    super.initState();
    getUser();
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

  sendUser(UserModel products) async {
    Uri url = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/userprofile.json");
    await http.post(url,
        body: jsonEncode({
          "name": products.email,
          "password": products.password,
          "role": products.role,
        }));
    getUser();
  }

  getUser() async {
    Uri url = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/userprofile.json");
    final response = await http.get(url);

    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    ctx.clear();
    extractedData.forEach((profileId, profileData) {
      ctx.add(
        UserModel(
          id: profileId,
          email: profileData['name'],
          password: profileData['password'],
          role: profileData['role'],
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
        ctx = templist.cast<UserModel>();
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
          const Text(
            'Data User',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
                        "Pengguna",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                DataColumn(
                  label: SizedBox(
                      width: 100,
                      child: Text(
                        "Password",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                DataColumn(
                  label: SizedBox(
                      width: 100,
                      child: Text(
                        "Role",
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
                                labelText: 'Masukan email pengguna',
                              ),
                            ),
                            TextFormField(
                              controller: productPriceCtr,
                              onChanged: (value) => productPriceCtr.text,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Masukan password pengguna',
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
                                String password = productPriceCtr.text;

                                setState(() {
                                  productNameCtr.clear();
                                  productPriceCtr.clear();
                                });

                                sendUser(UserModel(
                                    id: id,
                                    email: name,
                                    password: password,
                                    role: 'user'));
                                //storeProducts();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.teal,
                              ),
                              child: const Text('Tambah User'),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 130,
                            child: TextButton(
                              onPressed: () {
                                String id = getRandomString(5);
                                String name = productNameCtr.text;
                                String password = productPriceCtr.text;

                                setState(() {
                                  productNameCtr.clear();
                                  productPriceCtr.clear();
                                });

                                sendUser(UserModel(
                                    id: id,
                                    email: name,
                                    password: password,
                                    role: 'admin'));
                                //storeProducts();
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.teal,
                              ),
                              child: const Text('Tambah Admin'),
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
  List<UserModel> ctx;

  ProductDataTable(this.ctx) {
    //print(dataList);
  }
  // Generate some made-up data

  storeProducts(List<UserModel> data) async {
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
          jsonData.map((object) => UserModel.fromJson(object)).toList() ?? [];
      ctx = templist.cast<UserModel>();
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
            data.email,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(
          Text(
            data.password,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        DataCell(Text(data.role.toString())),
        // DataCell(Text(data.price.toString())),
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
