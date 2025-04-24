import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'liked_cubit.dart';

class LikedPage extends StatelessWidget {
  const LikedPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LikedCubit();
      },
      child: const LikedChildPage(),
    );
  }
}

class LikedChildPage extends StatefulWidget {
  const LikedChildPage({super.key});

  @override
  State<LikedChildPage> createState() => _LikedChildPageState();
}

class _LikedChildPageState extends State<LikedChildPage> {
  late final LikedCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
