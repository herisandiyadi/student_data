import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_student_app/common/theme.dart';
import 'package:test_student_app/common/utils.dart';
import 'package:test_student_app/data/models/student_model.dart';
import 'package:test_student_app/presentation/cubit/cubit/database_cubit.dart';
import 'package:test_student_app/presentation/home/homepage.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EditPage extends StatefulWidget {
  static const path = 'edit/:id';
  static const routeName = 'edit';
  final String id;
  const EditPage({super.key, required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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
  void initState() {
    context.read<DatabaseCubit>().selectbyId(int.tryParse(widget.id));
    super.initState();
  }

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
      body: Container(
        margin: const EdgeInsets.all(30),
        child: BlocBuilder<DatabaseCubit, DatabaseState>(
          builder: (context, state) {
            if (state is DatabaseSelect) {
              final data = state.data[0];
              return ListView(
                children: [
                  Text(
                    'Edit Data',
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
                      hintText: data['name'],
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
                        birtDateC.text =
                            CommonUtils.convertDateDDMMYYYY(result!);
                        birthDates = result;
                      });
                    },
                    readOnly: true,
                    controller: birtDateC,
                    style: dBlueTextStyle.copyWith(fontSize: 20),
                    decoration: InputDecoration(
                      hintText: data['birthDate'],
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
                      initialLabelIndex: data['gender'],
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
                      hintText: data['address'],
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
                      final students = StudentModel(
                        id: data['id'],
                        address: addressC.text.isNotEmpty
                            ? addressC.text
                            : data['address'],
                        age: ageInYears ?? data['age'],
                        birtDate: birtDateC.text.isNotEmpty
                            ? birtDateC.text
                            : data['birthDate'],
                        gender: genderIndex ?? data['gender'],
                        name: nameC.text.isNotEmpty ? nameC.text : data['name'],
                      );

                      context.read<DatabaseCubit>().update(students);
                    },
                    child: BlocListener<DatabaseCubit, DatabaseState>(
                      listener: (context, state) {
                        if (state is DatabaseUpdate) {
                          context.go(Homepage.path);
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
                        style: whiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: bold),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
