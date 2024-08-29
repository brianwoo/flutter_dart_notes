# Freezed Package
- Works with both Dart and Flutter projects

## Install
[Install Link](https://pub.dev/packages/freezed#install)

## Code Setup

- Data class Setup. Make sure to follow _$XXX and _XXX naming conventions
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
    @JsonKey(name: 'set-cookie') String? setCookie,
    String? date,
    @Default(4) int wheels,
  }) = _LoginResponse;

  // Convert json map to a data file
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

```
- To auto generate Dart data files (In project directory)
```bash
dart run build_runner build --delete-conflicting-outputs

# keep watching for changes
dart run build_runner watch --delete-conflicting-outputs
```

## fromJson (Json -> Data object)
```dart
final loginResp = LoginResponse.fromJson(response.headers);
```

## toJson (Data object -> Json)
```dart
final jsonObj = loginResp.toJson()
```

