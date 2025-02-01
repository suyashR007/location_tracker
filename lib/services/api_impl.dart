import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:location_tracker/constants/endpoints.dart';
import 'package:location_tracker/constants/var_type.dart';
import 'package:location_tracker/models/todo_model.dart';
import 'package:location_tracker/models/user_model/user_model.dart';
import 'package:location_tracker/services/api.dart';
import 'package:location_tracker/utils/exception.dart';
import 'package:location_tracker/utils/failure.dart';
import 'package:location_tracker/utils/helpers.dart';

class ApiServiceImpl implements ApiService {
  @override
  FutureData<List<TodoModel>> getTodos() async {
    try {
      final response = await Helpers.sendRequest(
        RequestType.get,
        EndPoints.todos,
      );

      final List<TodoModel> todos = (response as List)
          .map((todo) => TodoModel.fromMap(todo as Map<String, dynamic>))
          .toList();

      return Right(todos);
    } on ServerException catch (error, s) {
      debugPrintStack(stackTrace: s);
      return Left(ServerFailure(message: error.message.toString()));
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  FutureData<List<UserModel>> getUsers() async {
    try {
      final response = await Helpers.sendRequest(
        RequestType.get,
        EndPoints.users,
      );

      final List<UserModel> users = (response as List)
          .map((user) => UserModel.fromMap(user as Map<String, dynamic>))
          .toList();

      return Right(users);
    } on ServerException catch (error, s) {
      debugPrintStack(stackTrace: s);
      return Left(ServerFailure(message: error.message.toString()));
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
