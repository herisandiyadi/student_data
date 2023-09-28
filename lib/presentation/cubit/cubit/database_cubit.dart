import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_student_app/data/db/db_services.dart';
import 'package:test_student_app/data/models/student_model.dart';
part 'database_state.dart';

class DatabaseCubit extends Cubit<DatabaseState> {
  final DBServices dbServices;
  DatabaseCubit(this.dbServices) : super(DatabaseInitial());

  Future<void> insertData(StudentModel studentModel) async {
    try {
      await dbServices.insertStudents(studentModel);
      final result = await dbServices.getDataStudents();
      emit(const DatabaseInputSuccess('Input data berhasil'));

      emit(GetDatabase(result));
    } catch (e) {
      emit(const DatabaseFailed('Input data gagal'));
    }
  }

  Future<void> getData() async {
    try {
      final result = await dbServices.getDataStudents();

      emit(GetDatabase(result));
    } catch (e) {
      throw Exception('Load data gagal');
    }
  }

  Future<void> deleteById(int id) async {
    try {
      await dbServices.delete(id);
      emit(const DatabaseDelete('Delete berhasil'));
      final result = await dbServices.getDataStudents();
      emit(GetDatabase(result));
    } catch (e) {
      throw Exception('Terjadi kesalahan');
    }
  }

  Future<void> selectbyId(int? id) async {
    try {
      final result = await dbServices.selectById(id!);

      emit(DatabaseSelect(result));
    } catch (e) {
      throw Exception('Id tidak ditemukan');
    }
  }

  Future<void> update(StudentModel studentModel) async {
    try {
      await dbServices.update(studentModel);
      final result = await dbServices.getDataStudents();
      emit(const DatabaseUpdate('Data berhasil di update'));

      emit(GetDatabase(result));
    } catch (e) {
      throw Exception('Data gagal di update');
    }
  }
}
