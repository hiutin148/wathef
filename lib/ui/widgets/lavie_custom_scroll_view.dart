import 'package:flutter/material.dart';

class LavieCustomScrollView extends StatefulWidget {
  const LavieCustomScrollView({
    super.key,
    required this.slivers,
    this.onLoadMore,
    this.onRefresh,
    this.controller,
  });

  final List<Widget> slivers;
  final Future<void> Function()? onLoadMore;
  final RefreshCallback? onRefresh;
  final ScrollController? controller;

  @override
  State<LavieCustomScrollView> createState() => _LavieCustomScrollViewState();
}

class _LavieCustomScrollViewState extends State<LavieCustomScrollView> {
  final ValueNotifier<bool> _isLoadingMore = ValueNotifier<bool>(false);
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _isLoadingMore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (!mounted) return false;

        final bool endReached =
            notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 50;

        final bool shouldLoadMore =
            endReached && !_isLoadingMore.value && widget.onLoadMore != null;

        if (shouldLoadMore) {
          _isLoadingMore.value = true;
          widget.onLoadMore!().then((value) {
            _isLoadingMore.value = false;
          });
        }
        return true;
      },
      child:
          widget.onRefresh != null
              ? RefreshIndicator(
                onRefresh: widget.onRefresh!,
                child: _getScrollView(),
              )
              : _getScrollView(),
    );
  }

  Widget _getScrollView() {
    return CustomScrollView(
      clipBehavior: Clip.none,
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        ...widget.slivers,
        SliverToBoxAdapter(
          child: ValueListenableBuilder<bool>(
            valueListenable: _isLoadingMore,
            builder: (BuildContext context, bool value, Widget? child) {
              return value
                  ? Container(
                    margin: const EdgeInsets.all(20.0),
                    alignment: Alignment.center,
                    child: const SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(),
                    ),
                  )
                  : const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
