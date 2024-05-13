import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterInitialState());

  void increment() {
    final int newCounter = state.counter + 1;
    final String newStatus = newCounter % 2 == 0 ? "Genap" : "Ganjil";
    emit(CounterState(counter: newCounter, status: newStatus));
  }

  void decrement() {
    final int newCounter = state.counter - 1;
    final String newStatus = newCounter % 2 == 0 ? "Genap" : "Ganjil";
    emit(CounterState(counter: newCounter, status: newStatus));
  }
}
