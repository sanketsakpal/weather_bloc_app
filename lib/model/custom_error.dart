// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String errMsg;
  CustomError({
    this.errMsg = '',
  });

  @override
  String toString() => 'CustomError(errMsg: $errMsg)';

  @override
  List<Object?> get props => [errMsg];
}
