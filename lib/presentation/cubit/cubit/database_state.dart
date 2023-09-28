part of 'database_cubit.dart';

sealed class DatabaseState extends Equatable {
  const DatabaseState();

  @override
  List<Object> get props => [];
}

final class DatabaseInitial extends DatabaseState {}

final class DatabaseInputSuccess extends DatabaseState {
  final String message;
  const DatabaseInputSuccess(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

final class DatabaseLoading extends DatabaseState {}

final class GetDatabase extends DatabaseState {
  final List<Map<String, dynamic>> dataList;
  const GetDatabase(this.dataList);

  @override
  // TODO: implement props
  List<Object> get props => [dataList];
}

final class DatabaseFailed extends DatabaseState {
  final String message;
  const DatabaseFailed(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

final class DatabaseDelete extends DatabaseState {
  final String message;
  const DatabaseDelete(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

final class DatabaseSelect extends DatabaseState {
  final List<Map<String, dynamic>> data;
  const DatabaseSelect(this.data);

  @override
  // TODO: implement props
  List<Object> get props => [data];
}

final class DatabaseUpdate extends DatabaseState {
  final String message;
  const DatabaseUpdate(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
