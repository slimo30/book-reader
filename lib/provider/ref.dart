import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meduim_challenge/domain/my_domain.dart';
import 'package:meduim_challenge/utils/services.dart';

import '../models/mymodel.dart';

part 'my_event.dart';
part 'my_state.dart';
part 'ref.freezed.dart';

class MyRef extends StateNotifier<MyState> {
  MyRef() : super(MyState.empty());

  Future<void> mapEventsToStates(MyEvent event) async {
    await event.when(
      fetchData: () async {
        final isConnected = await AppServices.checkConnectivity();

        if (isConnected) {
          state = state.copyWith(isLoading: true);

          try {
            print("true");

            final data = await MyDomain.getData();
            print(data.toString());
            print("true 2");

            state = state.copyWith(
              myModelList: data,
              isLoading: false,
              isConnected: true,
            );
          } catch (e) {
            state = state.copyWith(
              isLoading: false,
              isConnected: false,
            );
          }
        } else {
          state = state.copyWith(
            isLoading: false,
            isConnected: false,
          );
        }
      },
    );
  }
}
