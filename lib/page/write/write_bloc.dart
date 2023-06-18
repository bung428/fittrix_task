import 'dart:async';

import 'package:fittrix_task/bloc/bloc_provider.dart';
import 'package:fittrix_task/model/const/exercise_type.dart';
import 'package:fittrix_task/model/record_model.dart';
import 'package:fittrix_task/service/api_service.dart';
import 'package:fittrix_task/service/auth_service.dart';
import 'package:fittrix_task/service/data/http_state.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

class WriteBLoC extends BLoC with BLoCStreamSubscription {
  late RecordModel model;

  final userId = AuthService.instance.model?.id;

  final btnEnable = BehaviorSubject<bool>()..value = false;
  Stream<bool> get btnEnableStream => btnEnable.stream;

  void setType(ExType type) {
    initModel(type);
  }

  void initModel(ExType type) {
    const uid = Uuid();
    if (userId == null) {
      return;
    }
    model = RecordModel(
      id: uid.v4(),
      msg: '',
      date: '',
      type: type.typeName,
      user_id: userId!
    );
  }

  @override
  void dispose() {
    btnEnable.close();
  }

  void setMessage(String value) {
    model = model.copyWith(msg: value);

    btnEnable.value = true;
  }

  void setCurrentDate() {
    final now = DateTime.now();
    final formatDate = DateFormat('yyyy-MM-dd').format(now);
    model = model.copyWith(date: formatDate);
  }

  Future<bool> saveRecord() {
    setCurrentDate();

    final completer = Completer<bool>();
    streamSubscription<HttpState>(
      stream: Stream.fromFuture(ApiService.instance.saveRecord(model)),
      onData: (data) {
        completer.complete(data == HttpState.success);
      },
      onError: (e) {
        completer.completeError(e);
        return;
      }
    );
    return completer.future;
  }
}