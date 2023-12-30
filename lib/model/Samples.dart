import 'package:flutter_app_native/model/PlayList.dart';

class Sample {
  final String uri;
  final String? drmLicenseUri;
  final String name;
  final String? drmScheme;
  final String? adTagUri;
  final String? subtitleUri;
  final String? subtitleMimeType;
  final String? subtitleLanguage;
  final String extension;
  final List<PlayListModel>? playlist;

  const Sample({
    required this.uri,
    this.drmLicenseUri,
    required this.name,
    this.drmScheme,
    this.adTagUri,
    this.subtitleUri,
    this.subtitleMimeType,
    this.subtitleLanguage,
    required this.extension,
    this.playlist,
  });

  factory Sample.fromJson(Map<String, dynamic> json) {
    var playListData = (json['playlist'] as List?);
    return Sample(
      uri: json['uri'] as String,
      drmLicenseUri: json['drm_license_uri'] as String?,
      name: json['name'] as String,
      drmScheme: json['drm_scheme'] as String?,
      adTagUri: json['ad_tag_uri'] as String?,
      subtitleUri: json['subtitle_uri'] as String?,
      subtitleMimeType: json['subtitle_mime_type'] as String?,
      subtitleLanguage: json['subtitle_language'] as String?,
      extension: json['extension'],
      playlist: playListData?.map((e) => PlayListModel.fromJson(e)).toList(),
    );
  }
}
