class UserData {
  final String imagePath;

  const UserData({
    required this.imagePath,
  });

  UserData copy({
    String? imagePath,
  }) =>
      UserData(
        imagePath: imagePath ?? this.imagePath,
      );

  static UserData fromJson(Map<String, dynamic> json) =>
      UserData(
        imagePath: json['imagePath'],
      );

  Map<String, dynamic> toJson() =>
      {
        'imagePath': imagePath,
      };
}
