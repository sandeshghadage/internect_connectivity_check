import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:internect_connectivity_check/bloc/internet_bloc/internet_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internect_connectivity_check/bloc/internet_bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  Connectivity _connectivity = Connectivity();
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitialState()) {
    on<InternetLostEvent>((event, emit) => emit(InternetLostState()));
    on<InternetGainedEvent>((event, emit) => emit(InternetGainedState()));

    connectivitySubscription = _connectivity.onConnectivityChanged.listen((Result) {
      if(Result == ConnectivityResult.mobile || Result == ConnectivityResult.wifi){
        add(InternetGainedEvent());
      }
      else if (Result != ConnectivityResult.mobile || Result != ConnectivityResult.wifi){
        add(InternetLostEvent());
      }
    });
  }
  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}