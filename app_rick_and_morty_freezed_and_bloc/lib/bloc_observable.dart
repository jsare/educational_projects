import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterBlocObservable extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent -- block: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('onError -- block: ${bloc.runtimeType}, error: $error');
  }
}
