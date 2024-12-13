class JoinedUser {
  //
  String id;
  String name;

  JoinedUser({required this.id, required this.name});

  JoinedUser.fromJson(Map<String, dynamic> map)
      : this(
          id: map['id'],
          name: map['name'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
