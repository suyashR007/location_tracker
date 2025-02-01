import 'package:dartz/dartz.dart';
import 'package:location_tracker/utils/failure.dart';

typedef FutureData<T> = Future<Either<Failure, T?>>;
