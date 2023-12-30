class PlayListModel {
  final String uri;
  final String drmLicenseUri;
  final String name;
  final int clipEndPositionMs;
  final int clipStartPositionMs;

  const PlayListModel({
    required this.uri,
    required this.drmLicenseUri,
    required this.name,
    required this.clipEndPositionMs,
    required this.clipStartPositionMs,
  });

  factory PlayListModel.fromJson(Map<String, dynamic> json) {
    return PlayListModel(
      uri: json['uri'] as String,
      drmLicenseUri: json['drm_license_uri'] as String,
      name: json['name'] as String,
      clipStartPositionMs: json['clip_start_position_ms'] as int,
      clipEndPositionMs: json['clip_end_position_ms'] as int,
    );
  }
}
