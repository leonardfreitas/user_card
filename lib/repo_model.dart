class Repo {
  int id;
  String name;
  String fullName;
  String userImage;

  Repo({
    required this.id,
    required this.name,
    required this.fullName,
    required this.userImage,
  });

  factory Repo.fromMap(Map<String, dynamic> map) {
    return Repo(
      id: map['id'] as int,
      name: map['name'] as String,
      fullName: map['full_name'] as String,
      userImage: map['owner']['avatar_url'] as String,
    );
  }
}
