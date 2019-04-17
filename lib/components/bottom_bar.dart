import 'package:flutter/material.dart';
import 'package:utopian_rocks_demo/blocs/contribution_bloc.dart';
import 'package:utopian_rocks_demo/blocs/steem_bloc.dart';
import 'package:utopian_rocks_demo/utils.dart';
import 'package:utopian_rocks_demo/providers/base_provider.dart';
import 'package:intl/intl.dart';

class BottomBar extends StatelessWidget {
  final ContributionBloc conBloc;

  BottomBar(this.conBloc);

  @override
  Widget build(BuildContext context) {
    final steemBloc = Provider.of<SteemBloc>(context);
    return BottomAppBar(
      color: Color(0xFF26A69A),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StreamBuilder(
            stream: steemBloc.timer,
            builder: (context, timerSnapshot) => Text(
              'Next vote cycle: ${DateFormat.Hms().format(
                DateTime(0,0,0,0,0, timerSnapshot.data ?? 0),
              )}',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          StreamBuilder(
            stream: steemBloc.voteCount,
            builder: (context, voteCountSnapshot) => Text(
              'Vote Power: ${voteCountSnapshot.data != 100.0 || null ? voteCountSnapshot.data?.toStringAsPrecision(4) ?? 0.0 : 100.00}',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: _generateMenu(categories, conBloc),
          )
        ],
      ),
    );
  }

  Widget _generateMenu(List<String> categories, ContributionBloc conBloc) {
    return PopupMenuButton<String>(
        tooltip: 'Filter Contribution Categories',
        onSelected: (cat) => conBloc.filter.add(cat),
        itemBuilder: (context) =>
            categories.map((cat) =>
                PopupMenuItem(
                  height: 40.0,
                  value: cat,
                  child: ListTile(
                    leading: Icon(IconData(icons[cat], fontFamily: 'Utopicons'),
                      color: colors[cat],),
                    title: Text(cat),
                  ),
                )).toList(),
    );
  }
}
