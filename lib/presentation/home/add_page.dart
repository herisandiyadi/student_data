import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_student_app/common/theme.dart';
import 'package:test_student_app/common/utils.dart';
import 'package:test_student_app/data/models/student_model.dart';
import 'package:test_student_app/presentation/cubit/cubit/database_cubit.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddPage extends StatefulWidget {
  static const path = 'add';
  static const routeName = 'add';

  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController nameC = TextEditingController();

  TextEditingController birtDateC = TextEditingController();

  TextEditingController genderC = TextEditingController();

  TextEditingController addressC = TextEditingController();
  bool isToggled = false;
  int? ageInYears;
  int? genderIndex;
  List<String> gender = ['Pria', 'Wanita'];
  DateTime? birthDates;
  @override
  void dispose() {
    nameC.dispose();
    birtDateC.dispose();
    genderC.dispose();
    addressC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            Text(
              'Input Data',
              textAlign: TextAlign.center,
              style: dBlueTextStyle.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: nameC,
              style: dBlueTextStyle.copyWith(fontSize: 20),
              decoration: InputDecoration(
                hintText: 'Nama Murid',
                hintStyle: greyTextStyle.copyWith(fontSize: 20),
              ),
            ),
            TextFormField(
              onTap: () async {
                final first = DateTime(
                  1940,
                );
                final result = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: first,
                    lastDate: DateTime.now());
                setState(() {
                  birtDateC.text = CommonUtils.convertDateDDMMYYYY(result!);
                  birthDates = result;
                });
              },
              readOnly: true,
              controller: birtDateC,
              style: dBlueTextStyle.copyWith(fontSize: 20),
              decoration: InputDecoration(
                hintText: 'BirthDate',
                hintStyle: greyTextStyle.copyWith(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: ToggleSwitch(
                minWidth: 90.0,
                initialLabelIndex: genderIndex,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                labels: gender,
                icons: const [Icons.male, Icons.female],
                activeBgColors: const [
                  [Colors.blue],
                  [Colors.pink]
                ],
                onToggle: (index) {
                  setState(() {
                    genderC.text = gender[index!];
                    genderIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: addressC,
              style: dBlueTextStyle.copyWith(fontSize: 20),
              decoration: InputDecoration(
                hintText: 'Address',
                hintStyle: greyTextStyle.copyWith(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(redColor)),
              onPressed: () {
                if (birtDateC != null) {
                  final currentDate = DateTime.now();
                  final difference = currentDate.difference(birthDates!);
                  ageInYears = (difference.inDays / 365).floor();
                }

                context.read<DatabaseCubit>().insertData(StudentModel(
                      address: addressC.text,
                      age: ageInYears!,
                      birtDate: birtDateC.text,
                      gender: genderC.text == 'Pria' ? 0 : 1,
                      name: nameC.text,
                    ));
              },
              child: BlocListener<DatabaseCubit, DatabaseState>(
                listener: (context, state) {
                  if (state is DatabaseInputSuccess) {
                    context.go('/');
                    const snackBar = SnackBar(
                      content: Text('Student berhasil ditambahkan'),
                      duration: Duration(seconds: 2),
                      backgroundColor: greenColor,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text(
                  'Submit',
                  style:
                      whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
