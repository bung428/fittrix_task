import 'package:fittrix_task/bloc/bloc_provider.dart';
import 'package:fittrix_task/model/const/exercise_type.dart';
import 'package:fittrix_task/page/write/write_bloc.dart';
import 'package:fittrix_task/util/enum_extension.dart';
import 'package:fittrix_task/util/validator.dart';
import 'package:fittrix_task/widget/app_btn.dart';
import 'package:fittrix_task/widget/box_widget.dart';
import 'package:fittrix_task/widget/stream_builder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class WritePage extends BLoCProvider<WriteBLoC> {
  const WritePage({Key? key, required this.exType}) : super(key: key);

  final String exType;

  @override
  Widget build(BuildContext context, WriteBLoC bloc) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final type = ExType.values.tryByName(exType);
    if (type == null) {
      return const Placeholder();
    }
    bloc.setType(type);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(type.typeName),
          leading: IconButton(onPressed: context.pop, icon: const Icon(Icons.arrow_back)),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: AspectRatio(
                    aspectRatio: 4/3,
                    child: Image.asset(type.image)
                  ),
                ),
                const ColumnBox(16),
                TextFormField(
                  textInputAction: TextInputAction.search,
                  validator: textEmptyValidator,
                  decoration: InputDecoration(
                      hintText: '메시지',
                      hintStyle: textTheme.labelMedium?.copyWith(color: Colors.grey),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      )
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  maxLength: 50,
                  onFieldSubmitted: bloc.setMessage,
                ),
                const Spacer(),
                StreamBuilderWidget(
                  stream: bloc.btnEnable,
                  builder: (context, enable) {
                    return AppButton(
                      onTap: enable != null && enable
                        ? () async {
                        final result = await bloc.saveRecord();
                        if (result) {
                          const snackBar = SnackBar(content: Text('기록이 저장되었습니다.'));
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          // ignore: use_build_context_synchronously
                          context.pop();
                        }
                      } : null,
                      child: const Text('Save'),
                    );
                  }
                )
              ],
            ),
          )
        )
    );
  }

  @override
  WriteBLoC createBLoC() => WriteBLoC();
}
