import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:test_student_app/common/theme.dart';
import 'package:test_student_app/presentation/auth/loginpage.dart';
import 'package:test_student_app/presentation/cubit/cubit/database_cubit.dart';
import 'package:test_student_app/presentation/detail/detail_page.dart';
import 'package:test_student_app/presentation/home/edit_page.dart';

class Homepage extends StatefulWidget {
  static const path = '/';
  static const routeName = 'homepage';

  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    context.read<DatabaseCubit>().getData();
  }

  alertLogout() async {
    return Alert(
        context: context,
        title: 'Logout',
        desc: 'Yakin ingin logout?',
        buttons: [
          DialogButton(
              color: Colors.red,
              child: const Text(
                'Ya',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => context.go(LoginPage.path)),
          DialogButton(
            color: Colors.red,
            child: const Text(
              'Tidak',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => context.pop(),
          ),
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Data'),
              Tab(text: 'Setting'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Konten Tab 1
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 30,
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            context.go('/add');
                          },
                          child: const Text('Add')),
                    ),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<DatabaseCubit, DatabaseState>(
                    builder: (context, state) {
                      if (state is GetDatabase) {
                        if (state.dataList.isNotEmpty) {
                          return ListView.builder(
                              itemCount: state.dataList.length,
                              itemBuilder: ((context, index) {
                                final data = state.dataList[index];
                                return Card(
                                  child: ListTile(
                                    onTap: () async {
                                      final result = await context.pushNamed(
                                          DetailPage.routeName,
                                          pathParameters: {
                                            'id': (data['id']).toString()
                                          });

                                      if (mounted && result == null) {
                                        refresh();
                                      }
                                    },
                                    title: Text(state.dataList[index]['name']),
                                    trailing: SizedBox(
                                      width: 100,
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                context.pushNamed(
                                                    EditPage.routeName,
                                                    pathParameters: {
                                                      'id': (data['id'])
                                                          .toString()
                                                    });
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: blueColor,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                context
                                                    .read<DatabaseCubit>()
                                                    .deleteById(state
                                                        .dataList[index]['id']);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: redColor,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }));
                        }
                      }
                      return const SizedBox(
                        child: Center(
                          child: Text('Data Kosong'),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            // Konten Tab 2
            Center(
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(redColor)),
                    onPressed: () => alertLogout(),
                    child: Text(
                      'LOGOUT',
                      style: whiteTextStyle.copyWith(
                          fontSize: 16, fontWeight: bold),
                    ))),
          ],
        ),
      ),
    );
  }
}
