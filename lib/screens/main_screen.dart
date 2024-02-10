import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_area/theme/palette.dart';
import 'package:personal_area/widgets/custom_elevated_button.dart';
import 'package:personal_area/widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StateMainScreen();
}

final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class _StateMainScreen extends State<MainScreen> {
  //firestore
  final testProjectDb =
      FirebaseFirestore.instance.collection('test_project_db');
  bool _isLoading = false;

  void showInSnackBar(String value, { Color? color}) {
    _scaffoldKey.currentState!.showSnackBar(
        SnackBar(content: Center(child: Text(value)), backgroundColor: color,)
    );
  }

  late TextEditingController surnameController;
  late TextEditingController nameController;
  late TextEditingController parentNameController;
  late String deviceID;
  late SharedPreferences preferences;
  final String uniqueID = 'uuid';

  Future<void> _initID() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(uniqueID)) {
      deviceID = preferences.getString(uniqueID) ?? '';
    } else {
      const uuid = Uuid();
      deviceID = uuid.v4();
      preferences.setString(uniqueID, deviceID);
    }
  }

  Future<void> _getFirestoreData() async {
    setState(() {
      _isLoading = true;
    });
    await _initID();
    DocumentSnapshot data =
        await testProjectDb.doc(deviceID).get();
    if (data.exists) {
      surnameController.text = data.get('user_surname').toString();
      nameController.text = data.get('user_name').toString();
      parentNameController.text = data.get('user_parent_name').toString();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    surnameController = TextEditingController();
    nameController = TextEditingController();
    parentNameController = TextEditingController();
    _getFirestoreData();
  }

  @override
  void dispose() {
    surnameController.dispose();
    nameController.dispose();
    parentNameController.dispose();
    super.dispose();
  }

  void _saveUser() async {
    if (surnameController.text.isEmpty ||
        nameController.text.isEmpty ||
        parentNameController.text.isEmpty) {
      showInSnackBar("Заполните поля", color: Colors.red);
      return;
    }
    setState(() {
      _isLoading = true;
    });
    await testProjectDb
        .doc(deviceID)
        .set({
          "user_surname": surnameController.text,
          "user_name": nameController.text,
          "user_parent_name": parentNameController.text
        })
        .then((_) => {showInSnackBar("Успешно сохранен!", color: Colors.green)})
        .catchError((_) => {
              setState(() {
                _isLoading = false;
              })
            });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        backgroundColor: Palette.scaffold,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Личный кабинет',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Palette.primaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: surnameController,
                hintText: 'Фамилия',
                height: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: nameController,
                hintText: 'Имя',
                height: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: parentNameController,
                hintText: 'Отчество',
                height: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomElevatedButton(
                onPressed: () => {_saveUser()},
                loading: _isLoading,
                buttonText: 'Сохранить',
                width: double.infinity,
                height: 50,
              )
            ],
          ),
        )),
      ),
    );
  }
}
