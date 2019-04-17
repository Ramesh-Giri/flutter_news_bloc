import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'models/model.dart';
import 'package:flutter/material.dart';

const categories = [
  'ideas',
  'development',
  'bug-hunting',
  'translations',
  'graphics',
  'analysis',
  'documentation',
  'tutorials',
  'video-tutorials',
  'copywriting',
  'blog',
  'social',
  'anti-abuse',
  'all',
];

const icons = <String, int>{
  'ideas': 0x0049,
  'development': 0x0046,
  'bug-hunting': 0x0043,
  'translations': 0x004a,
  'graphics': 0x0045,
  'analysis': 0x0041,
  'documentation': 0x0047,
  'tutorials': 0x004b,
  'video-tutorials': 0x0048,
  'copywriting': 0x0044,
  'blog': 0x0042,
  'social': 0x004c,
  'anti-abuse': 0x0050,
  'all': 0x004e,
};

const colors = <String, Color>{
  'ideas': Color(0xFF4DD39F),
  'development': Color(0xFFFFa032),
  'bug-hunting': Color(0xFF4D524c),
  'translations': Color(0xFF4FF000),
  'graphics': Color(0xFFFF0000),
  'analysis': Color(0xFF4DD39F),
  'documentation': Color(0xFFFFa032),
  'tutorials': Color(0xFF4DD39F),
  'video-tutorials': Color(0xFF4DD39F),
  'copywriting': Color(0xFFFF0000),
  'blog': Color(0xFF4DD39F),
  'social': Color(0xFFFFa032),
  'anti-abuse': Color(0xFF4DD39F),
  'all': Color(0xFFFFa032),
};

int getIcons(AsyncSnapshot snapshot, int index) {
  return icons[snapshot.data[index].category];
}

Color getCategoryColor(AsyncSnapshot snapshot, int index) {
  return colors[snapshot.data[index].category];
}

String checkRepo(AsyncSnapshot snapshot, int index) {
  if (snapshot.data[index].repository != "") {
    return snapshot.data[index].repository;
  } else {
    return "No Repository";
  }
}

String convertTimeStamp(AsyncSnapshot snapshot, int index, String pageName) {
  if (pageName == "unreviewed") {
    return "Created: ${timeago.format(DateTime.parse(snapshot.data[index].created))}";
  }
  return "Reviewed: ${timeago.format(DateTime.parse(snapshot.data[index].reviewDate))}";
}

void launchUrl(String url) async {
  if (await canLaunch(url)) {
    print("Launching : $url");
  } else {
    print("Could not launch $url");
  }
}

List<Contribution> applyFilter(
  String filter,
  List<Contribution> contributions,
) {
  if (filter != 'all') {
    return contributions.where((con) => con.category == filter).toList();
  }

  return contributions;
}
