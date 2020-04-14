import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:wishlisttracker/utility/apiCalling.dart';

class MasterWebsite extends ChangeNotifier {
  ValueNotifier<List<MasterWebsite>> _vendorWebsite;
  ValueNotifier<bool> _hasInternet;

  String websiteName;
  String title;
  String url;
  String chipC;
  int brandColor;

  MasterWebsite.initial()
      : websiteName = '',
        title = "",
        chipC = "",
        brandColor = 4294158407,
        url = "";

  MasterWebsite({
    this.websiteName,
    this.title,
    this.url,
    this.chipC,
    this.brandColor,
  });

  List<MasterWebsite> get getVendorWebsite =>
      _vendorWebsite != null ? _vendorWebsite.value : [];

  bool get getHasInternet => _hasInternet == null ? true : _hasInternet.value;

  MasterWebsite.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      websiteName = json["websiteName"];
      title = json["title"];
      url = json["url"];
      brandColor = int.tryParse(json["brandColor"]);
      chipC = json["websiteName"][0];
    }
  }

  List<MasterWebsite> masterWebsiteParser(dynamic responseBody) {
    return responseBody
        .map<MasterWebsite>((json) => MasterWebsite.fromJson(json))
        .toList();
  }

  void getMasterWebsiteProvider() async {
    var dynamicBody = await ApiCalling.getReq('get_master_website');
    if (dynamicBody != null) {
      dynamicBody = json.decode(dynamicBody);
      List<MasterWebsite> tempO = masterWebsiteParser(dynamicBody);
      _vendorWebsite = new ValueNotifier<List<MasterWebsite>>(tempO);
    }
    if (_vendorWebsite != null) {
      _vendorWebsite.notifyListeners();
      notifyListeners();
    }
  }

  void setHasInternet(bool hasIn) {
    _hasInternet.value = hasIn;
    if (_hasInternet != null) {
      _hasInternet.notifyListeners();
      notifyListeners();
    }
  }
}
