import 'dart:async';

import 'package:fittrix_task/bloc/bloc_provider.dart';
import 'package:fittrix_task/model/const/exercise_type.dart';
import 'package:fittrix_task/model/record_model.dart';
import 'package:fittrix_task/service/api_service.dart';
import 'package:rxdart/rxdart.dart';

const limit = 10;

class ReadBLoC extends BLoC with BLoCStreamSubscription {
  late ExType exType;
  int currentPage = 0;

  final exRecords = BehaviorSubject<List<RecordModel>>();
  Stream<List<RecordModel>> get exRecordsStream => exRecords.stream;

  void setType(ExType type) {
    exType = type;
    init();
  }

  void init() async {
    final result = await fetch();
    exRecords.value = result;
  }

  Future<List<RecordModel>> fetch() {
    final completer = Completer<List<RecordModel>>();

    currentPage = getQuotient();
    streamSubscription(
        stream: Stream.fromFuture(
          ApiService.instance.getExerciseRecords(exType, currentPage, limit: limit)
        ),
        onData: (data) {
          sortRecordList(data);
          completer.complete(data);
        },
        onError: (e) {
          completer.completeError(e);
          return;
        }
    );
    return completer.future;
  }

  @override
  void dispose() {
    exRecords.close();
  }

  int getQuotient() {
    final recordList = exRecords.hasValue ? exRecords.value : [];
    int quotient = 0;
    if (recordList.isNotEmpty) {
      quotient = recordList.length ~/ limit;
      if (quotient > 0) {
        quotient += 1;
      }
    }

    return quotient == 0 ? 1 : quotient;
  }

  Future<void> loadMore() async {
    if (currentPage == getQuotient()) {
      return;
    }
    final result = await fetch();
    exRecords.value = [...exRecords.value, ...result];
  }

  void sortRecordList(List<RecordModel> list) {

  }
}