import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../model/ahp/ahp_alternatif_model.dart';
import '../../model/ahp/ahp_kriteria_model.dart';
import 'package:http/http.dart' as http;

import 'ahp_alternatif_component.dart';
import 'ahp_kriteria_component.dart';

GetStorage box = GetStorage();

class AhpComponent extends StatefulWidget {
  const AhpComponent({super.key});

  @override
  State<AhpComponent> createState() => _AhpComponentState();
}

class _AhpComponentState extends State<AhpComponent> {
  int count = 0;
  List<AhpKriteriaModel> ctxKriteria = [];
  List<AhpAlternatifModel> ctxAlternatif = [];

  KriteriaDataTable dataSource = KriteriaDataTable([]);
  AlternatifDataTable dataSourceAlt = AlternatifDataTable([]);

  @override
  void initState() {
    super.initState();
    //getdbProduct();
    getKriteria();
    getAlternatif();
  }

  getKriteria() async {
    Uri url = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/ahp_data_kriteria.json");
    final response = await http.get(url);

    if (response.body != "null") {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      ctxKriteria.clear();
      extractedData.forEach((profileId, profileData) {
        ctxKriteria.add(
          AhpKriteriaModel(
              id: profileId,
              kode: profileData['kode'],
              namaKriteria: profileData['namaKriteria']),
        );
      });
    }

    setState(() {
      ctxKriteria;
      dataSource = KriteriaDataTable(ctxKriteria);
      // controller.isupdateTable.value = false;
    });
  }

  getAlternatif() async {
    Uri url = Uri.parse(
        "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/ahp_data_alternatif.json");
    final response = await http.get(url);

    if (response.body != "null") {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      ctxAlternatif.clear();
      extractedData.forEach((profileId, profileData) {
        ctxAlternatif.add(
          AhpAlternatifModel(
              id: profileId,
              kode: profileData['kode'],
              namaAlternatif: profileData['namaAlternatif']),
        );
      });
    }

    setState(() {
      ctxAlternatif;
      dataSourceAlt = AlternatifDataTable(ctxAlternatif);
      // controller.isupdateTable.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  const Text(
                    'Data Kriteria',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: Get.width * .42,
                    //width: Get.width * .4,
                    height: 240,
                    child: PaginatedDataTable(
                      source: dataSource,
                      arrowHeadColor: Colors.blue,
                      onPageChanged: (value) => count,
                      columnSpacing: 0,
                      horizontalMargin: 5,
                      rowsPerPage: 5,
                      headingRowHeight: 20,
                      dataRowHeight: 30,
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
                              width: 200,
                              child: Text(
                                "Data Kriteria",
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                      ],
                    ),
                  ),
                ]),
                Column(children: [
                  const Text(
                    'Data Alternatif',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: Get.width * .42,
                    //width: Get.width * .4,
                    height: 240,
                    child: PaginatedDataTable(
                      source: dataSourceAlt,
                      arrowHeadColor: Colors.blue,
                      onPageChanged: (value) => count,
                      columnSpacing: 0,
                      horizontalMargin: 5,
                      rowsPerPage: 5,
                      headingRowHeight: 20,
                      dataRowHeight: 30,
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
                              width: 200,
                              child: Text(
                                "Data Alternatif",
                                overflow: TextOverflow.ellipsis,
                              )),
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 40,
                  width: 250,
                  child: TextButton(
                    onPressed: () => Get.to(const AhpKriteriaDataComponent()),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent,
                    ),
                    child: const Text('Tambah Kriteria'),
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 250,
                  child: TextButton(
                    onPressed: () => Get.to(const AhpAlternatifDataComponent()),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent,
                    ),
                    child: const Text('Tambah Alternatif'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class KriteriaDataTable extends DataTableSource {
  List<AhpKriteriaModel> ctx;

  KriteriaDataTable(this.ctx) {
    //print(dataList);
  }

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
      ],
    );
  }
}

class AlternatifDataTable extends DataTableSource {
  List<AhpAlternatifModel> ctx;

  AlternatifDataTable(this.ctx) {
    //print(dataList);
  }

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
        DataCell(Text(data.namaAlternatif.toString())),
      ],
    );
  }
}
