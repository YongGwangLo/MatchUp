import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
    required this.dimension,
    required this.profile,
  });

  final double dimension;
  final String profile;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          profile,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
