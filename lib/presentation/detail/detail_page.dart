import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_student_app/common/theme.dart';
import 'package:test_student_app/presentation/cubit/cubit/database_cubit.dart';
import 'package:test_student_app/presentation/home/edit_page.dart';

class DetailPage extends StatefulWidget {
  static const path = 'detail/:id';
  static const routeName = 'detail';
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<String> gender = ['Pria', 'Wanita'];
  @override
  void initState() {
    context.read<DatabaseCubit>().selectbyId(int.parse(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: true,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: darkBlueColor,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Detail Page',
              style: dBlueTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
          ],
        ),
        backgroundColor: whiteColor,
      ),
      body: BlocBuilder<DatabaseCubit, DatabaseState>(
        builder: (context, state) {
          if (state is DatabaseSelect) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final data = state.data[0];
                return Container(
                  margin: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(blueColor)),
                            onPressed: () {
                              context.pushNamed(EditPage.routeName,
                                  pathParameters: {
                                    'id': (data['id']).toString()
                                  });
                            },
                            child: Text(
                              'EDIT',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 14, fontWeight: bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: CircleAvatar(
                          maxRadius: 70,
                          backgroundColor: greyColor,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Nama : ${data['name']}',
                        style: dBlueTextStyle.copyWith(
                            fontSize: 20, fontWeight: bold),
                      ),
                      Text(
                        'Tanggal Lahir : ${data['birthDate']}',
                        style: dBlueTextStyle.copyWith(
                            fontSize: 20, fontWeight: bold),
                      ),
                      Text(
                        'Umur : ${data['age']}',
                        style: dBlueTextStyle.copyWith(
                            fontSize: 20, fontWeight: bold),
                      ),
                      Text(
                        'Jenis Kelamin : ${gender[data['gender']]}',
                        style: dBlueTextStyle.copyWith(
                            fontSize: 20, fontWeight: bold),
                      ),
                      Text(
                        'Umur : ${data['address']}',
                        style: dBlueTextStyle.copyWith(
                            fontSize: 20, fontWeight: bold),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
