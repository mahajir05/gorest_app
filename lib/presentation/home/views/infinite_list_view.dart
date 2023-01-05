import 'package:flutter/material.dart';

import '../../../domain/core/interfaces/widget_utils.dart';

class InfiniteListView<T> extends StatefulWidget {
  final bool isLoading;
  final bool isMaxData;
  final List<T> items;
  final Function()? onMaxScroll;
  final Function(dynamic)? onItemTap;

  const InfiniteListView({
    Key? key,
    required this.items,
    required this.isLoading,
    this.isMaxData = false,
    this.onMaxScroll,
    this.onItemTap,
  }) : super(key: key);

  @override
  State<InfiniteListView> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
          widget.isLoading == false &&
          widget.isMaxData == false) {
        if (widget.onMaxScroll != null) widget.onMaxScroll!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.isMaxData ? widget.items.length : widget.items.length + 1,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == widget.items.length) {
          return Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }
        return InkWell(
          onTap: () {
            if (widget.onItemTap != null) widget.onItemTap!(widget.items[index]);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                WidgetUtils.labelText(
                  title: 'ID',
                  value: widget.items[index]?.id,
                  isUserBorder: false,
                ),
                WidgetUtils.labelText(
                  title: 'Name',
                  value: widget.items[index]?.name,
                  isUserBorder: false,
                ),
                WidgetUtils.labelText(
                  title: 'Email',
                  value: widget.items[index]?.email,
                  isUserBorder: false,
                ),
                WidgetUtils.labelText(
                  title: 'Gender',
                  value: widget.items[index]?.gender,
                  isUserBorder: false,
                ),
                WidgetUtils.labelText(
                  title: 'Status',
                  value: widget.items[index]?.status,
                  isUserBorder: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
