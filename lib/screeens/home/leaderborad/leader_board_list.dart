import 'package:flutter/material.dart';
import '../../../constracts.dart';
import '../../../widgets/styled_text.dart';

class LeaderBoardListView extends StatefulWidget {
  final dynamic users;

  const LeaderBoardListView({Key? key, required this.users}) : super(key: key);

  @override
  State<LeaderBoardListView> createState() => _LeaderBoardListViewState();
}

class _LeaderBoardListViewState extends State<LeaderBoardListView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scrollbar(
      child: SizedBox(
        height: 0.60 * height,
        child: ListView.builder(
            itemCount: widget.users.length,
            itemBuilder: (context, index) {
              final user = widget.users[index];
              return bulidListTile(user, index);
            }),
      ),
    );
  }

  Widget bulidListTile(user, int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: orangeColor,
          child: CustomText(data: '${index + 1}', size: 15.0),
        ),
        title: CustomText(
          data: '${user.name}',
          size: 17.0,
          color: blueColor,
          weight: FontWeight.w700,
        ),
        trailing:
            CustomText(data: '${user.score}', size: 17.0, color: blackColor),
      ),
    );
  }
}
