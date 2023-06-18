import 'package:fittrix_task/model/expanded_model.dart';
import 'package:fittrix_task/page/main/data/video_state.dart';
import 'package:fittrix_task/page/main/main_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('main bloc group test', () {
    final bloc = MainBLoC();
    test('setVideoDone test', () {
      expect(bloc.videoState.value, VideoState.done);
    });
    test('resetModel test', () {
      expect(bloc.menuExpanded.value, ExpandedModel(
          null, false
      ));
    });
  });
}