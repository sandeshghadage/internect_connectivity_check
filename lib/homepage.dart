import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internect_connectivity_check/bloc/internet_bloc/internet_bloc.dart';
import 'package:internect_connectivity_check/bloc/internet_bloc/internet_state.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<InternetBloc, InternetState>(
          listener: (context, state) {
            if(state is InternetGainedState){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Internet Connected'),
                  backgroundColor: Colors.green,
                ),
              );
            }
            else if(state is InternetLostState){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Internet Disconnected'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is InternetGainedState) {
              return Text('Internet Connected');
            } else if (state is InternetLostState) {
              return Text('Internet Disconnected');
            } else {
              return Text('Loading...');
            }
          },
        ),
      ),
    );
  }
}
