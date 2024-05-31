class CreateUserRequest {
  final String username;
  final String password;

  const CreateUserRequest({
    required this.username,
    required this.password,
  });

  CreateUserRequest copyWith({
    String? username,
    String? password,
  }) {
    return CreateUserRequest(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) {
    return CreateUserRequest(
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
