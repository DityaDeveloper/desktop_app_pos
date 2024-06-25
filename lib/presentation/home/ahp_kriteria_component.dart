import 'dart:convert';

import 'package:desktop_app_pos/model/ahp/ahp_kriteria_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

import '../../controller/product_mng_component.dart';
import '../../model/ahp/ahp_alternatif_model.dart';

GetStorage box = GetStorage();

class AhpKriteriaDataComponent extends StatefulWidget {
  const AhpKriteriaDataComponent({super.key});

  @override
  State<AhpKriteriaDataComponent> createState() =>
      _AhpKriteriaDataComponentState();
}

class _AhpKriteriaDataComponentState
    extends State<AhpKriteriaDataComponent> {
  TextEditingController namaKriteriaCtr = TextEditingController();
  TextEditingController kodeCtr = TextEditingController();

  int count = 0;
  List<AhpKriteriaModel> ctx = [];

  @override
  void initState() {
    super.initState();
    //getdbProduct();
    getProducts();
  }

  storeProducts() async {
    var paymentsAsMap = ctx.map((payment) => payment.toJson()).toList();
    String jsonString = jsonEncode(paymentsAsMap);
    await box.write('kriteria', jsonString);
    debugPrint('success add : $paymentsAsMap');
    setState(() {
      dataSource = ProductDataTable(ctx);
    });
  }

  sendProducts(AhpKriteriaModel item) async {
    Uri url = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/ahp_data_kriteria.json");
    await http.post(url,
        body: jsonEncode({
          "id": item.id,
          "namaKriteria": item.namaKriteria,
          "kode": item.kode
        }));
    getProducts();
  }

  getProducts() async {
    Uri url = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/ahp_data_kriteria.json");
    final response = await http.get(url);

    if (response.body != "null") {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      ctx.clear();
      extractedData.forEach((profileId, profileData) {
        ctx.add(
          AhpKriteriaModel(
              id: profileId,
              kode: profileData['kode'],
              namaKriteria: profileData['namaKriteria']),
        );
      });
    }

    setState(() {
      ctx;
      dataSource = ProductDataTable(ctx);
     // controller.isupdateTable.value = false;
    });
  }

  getdbProduct() {
    var result = box.read('kriteria');
    List<dynamic> templist = [];
    if (result == null) {
      debugPrint('is null');
      ctx = [];
    } else {
      debugPrint('is not null');
      dynamic jsonData = jsonDecode(result);
      setState(() {
        templist = jsonData
                .map((object) => AhpKriteriaModel.fromJson(object))
                .toList() ??
            [];
        ctx = templist.cast<AhpKriteriaModel>();
        dataSource = ProductDataTable(ctx);
       // controller.isupdateTable.value = false;
      });
    }
  }

  ProductDataTable dataSource = ProductDataTable([]);

  String chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  math.Random rnd = math.Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

  //final controller = Get.put(ProductManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text(
            'Data Kriteria',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: double.infinity,
         //width: Get.width * .4,
            height: 370,
            child: PaginatedDataTable(
              source: dataSource,
              arrowHeadColor: Colors.blue,
              onPageChanged: (value) => count,
              columnSpacing: 2,
              horizontalMargin: 2,
              rowsPerPage: 5,
              showCheckboxColumn: false,
              //minWidth: 700,
              columns: const [
                DataColumn(
                  label: SizedBox(
                      width: 50,
                      child: Text(
                        "no",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                DataColumn(
                  label: SizedBox(
                      width: 100,
                      child: Text(
                        "Kode",
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                DataColumn(
                  label: SizedBox(
                      width: 100,
                      child: Text(
                        "Data Kriteria",
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
                    Container(
                        width: Get.width * .2, height: 200, color: Colors.red),
                    SizedBox(
                      width: Get.width * .5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: kodeCtr,
                              onChanged: (value) => kodeCtr.text,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Masukan kode',
                              ),
                            ),
                            TextFormField(
                              controller: namaKriteriaCtr,
                              onChanged: (value) => namaKriteriaCtr.text,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Masukan nama kriteria',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * .25,
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
                                String kode = kodeCtr.text;
                                String namaKriteria = namaKriteriaCtr.text;

                                setState(() {
                                  kodeCtr.clear();
                                  namaKriteriaCtr.clear();
                                });

                                sendProducts(AhpKriteriaModel(
                                  id: id,
                                  kode: kode,
                                  namaKriteria: namaKriteria,
                                ));
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
                              // onPressed: () => Get.to(const Home()),
                              onPressed: () => Get.back(),
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
  List<AhpKriteriaModel> ctx;

  ProductDataTable(this.ctx) {
    //print(dataList);
  }
  // Generate some made-up data

  storeProducts(List<AhpKriteriaModel> data) async {
    var paymentsAsMap = data.map((payment) => payment.toJson()).toList();
    String jsonString = jsonEncode(paymentsAsMap);
    await box.write('products', jsonString);
    debugPrint('success add : $paymentsAsMap');
  }

  getProductAfterDelete() {
    var result = box.read('products');
    List<dynamic> templist = [];

    if (result == null) {
      debugPrint('is null');
      ctx = [];
    } else {
      debugPrint('is not null');

      dynamic jsonData = jsonDecode(result);
      templist = jsonData
              .map((object) => AhpKriteriaModel.fromJson(object))
              .toList() ??
          [];
      ctx = templist.cast<AhpKriteriaModel>();
    }
  }

  deleteProducts(AhpKriteriaModel products) async {
    Uri url = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/ahp_data_alternatif/${products.id}.json");
    await http.delete(url);
    // getdbProduct();
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
    int no = index + 1;
    var data = ctx[index];
    return DataRow(
      cells: [
        DataCell(
          Text(
            no.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        
        DataCell(Text(data.kode.toString())),
        DataCell(Text(data.namaKriteria.toString())),
        DataCell(InkWell(
            onTap: () {
              debugPrint('success delete $data');
              debugPrint('$ctx');
              deleteProducts(data);
              ctx.remove(data);

              notifyListeners();
            },
            child: const Icon(Icons.delete, color: Colors.red))),
      ],
    );
  }
}
