# Freezed Package
- Works with both Dart and Flutter projects

## Install
[Install Link](https://pub.dev/packages/freezed#install)

## Code Setup

- Data class Setup:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

// Auto generate the following dart files
part 'login_response.freezed.dart';
part 'login_response.g.dart';

// Use @freezed annotation
@freezed
// Use the Mix-in
sealed class LoginResponse with _$LoginResponse {
  // Create a factory constructor with fields
  factory LoginResponse({
    String? location,
    String? setCookie,
    String? date,
  }) = _LoginResponse;

  // Convert json map to a data file
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

```
