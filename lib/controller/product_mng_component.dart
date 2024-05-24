import 'package:get/get.dart';

class ProductManagementController extends GetxController{
  
  var isupdateTable = false.obs;

  isupdatePage(bool value) => isupdateTable.value = value;

}