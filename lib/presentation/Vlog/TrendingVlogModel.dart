// To parse this JSON data, do
//
//     final trendingVlogModel = trendingVlogModelFromJson(jsonString);

import 'dart:convert';
import '../../data/models/vlog_model.dart';

TrendingVlogModel trendingVlogModelFromJson(String str) => TrendingVlogModel.fromJson(json.decode(str));


class TrendingVlogModel {
    bool? success;
    int? status;
    String? message;
    List<Vlog>? vlogs;

    TrendingVlogModel({
        this.success,
        this.status,
        this.message,
        this.vlogs,
    });

    factory TrendingVlogModel.fromJson(Map<String, dynamic> json) => TrendingVlogModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        vlogs: json["vlogs"] == null ? [] : List<Vlog>.from(json["vlogs"]!.map((x) => Vlog.fromJson(x))),
    );


}


