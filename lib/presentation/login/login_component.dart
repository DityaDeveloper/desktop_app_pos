// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

import '../../model/user/user_model.dart';
import '../home/home.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({super.key});

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  List<UserModel> loadedProfile = [];
  bool isrender = false;
  bool isValidAccount = false;
  bool isEmailTrue = false;
  bool isPasswordTrue = false;
  List<UserModel> ctx = [];

  TextEditingController usernameCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    });
  }

  List<dynamic> isAccountLogin = [];

  void findEmailAndPw(String email, String pw) {
    getUser();
    if(email == '' && pw == ''){
       Get.snackbar('Gagal', 'Email dan password kosong');
    } else{
      setState(() {
        
      isAccountLogin.clear();
      List<dynamic> tempAccount1 = [];
      List<dynamic> tempAccount2 = [];
      tempAccount1.clear();
      tempAccount2.clear();
      isAccountLogin = ctx
          .where((item) =>
              item.email == email.toLowerCase())
          .toList();
     
      if(isAccountLogin == []){
        tempAccount1.clear();
        print('temp acc clear');
      } else{
        tempAccount1.add(isAccountLogin);
        print('acc $ctx');
        print('temp acc add $isAccountLogin');
      }
       print('is account 1 : $isAccountLogin - $tempAccount1');
      if(tempAccount1 != []){
        setState(() {
          isEmailTrue = true;
        });
      } else{
        setState(() {
          isEmailTrue = false;
        });
      }
      isAccountLogin.clear();
      isAccountLogin = ctx
          .where((item) =>
              item.password == pw.toLowerCase())
          .toList();
      print('is account 2 : $isAccountLogin');
      if(isAccountLogin != []){
        tempAccount2.add(isAccountLogin);
      } else{
        tempAccount2.clear();
      }
      if( tempAccount2 != []){
        setState(() {
          isPasswordTrue = true;
        });
      } else{
        setState(() {
          isPasswordTrue = false;
        });
      }
        print('email : $isEmailTrue pw : $isEmailTrue $tempAccount1 $tempAccount2');
      
    });
    if(isEmailTrue == true || isPasswordTrue == true){
     setState(() {
        isValidAccount = true;
     });
   
     Get.snackbar('Berhasil', 'Akun ditemukan');
    }else{
     Get.snackbar('Gagal', 'Akun tidak ditemukan');
    }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Container(
            color: Colors.blueGrey,
            width: Get.width * .5,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   "Sistem Pendukung Keputusan (Analytical Hierarchy Process)",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       color: Colors.white, fontWeight: FontWeight.bold),
                // ),
                Text(
                  "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   "POS Ku",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       color: Colors.white, fontWeight: FontWeight.bold),
                // ),
                Text(
                  "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   "@2023 - Ditya Developer",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       color: Colors.white, fontWeight: FontWeight.bold),
                // ),
              ],
            ),
          ),
          Container(
            width: Get.width * .5,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: usernameCtr,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Masukan email',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: passwordCtr,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Masukan password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 100,
                  child: GFButton(
                    onPressed: () async {
                      String email = usernameCtr.text;
                      String password = passwordCtr.text;
                      Get.off(() => const Home());
                      // if(email == 'prayogi@owner.xyz' && password ==  "123456"){
                      // Get.off(() => const Home());
                      // } else{
                      //   Get.snackbar('invalid access', 'akun masih terbatas');
                      // }
                     // findEmailAndPw(email, password);
                      usernameCtr.clear();
                      passwordCtr.clear();
                      /*
                      Uri url = Uri.parse(
                          "https://client-prayogi-spkahp-default-rtdb.firebaseio.com/userprofile.json");
                      await http.post(url,
                          body: jsonEncode(
                              {"id": "1", "name": "prayogi@owner.xyz",  "password": "123456", "role": "admin"}));
                    */
                    },
                    text: "masuk",
                    icon: const Icon(
                      Icons.login,
                      color: Colors.blue,
                    ),
                    type: GFButtonType.outline,
                  ),
                ),
                if (isrender) Text(loadedProfile[0].email)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
