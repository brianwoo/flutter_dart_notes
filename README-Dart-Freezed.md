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

String? cookieAspXformAuthFromJson(String? cookie) {
  if (cookie == null) {
    return null;
  }

  final cookieSplitted = cookie.split(';');
  if (cookieSplitted.isEmpty) {
    return null;
  }

  String foundFormsAuth = cookieSplitted.firstWhere(
    (element) => element.contains('.ASPXFORMSAUTH'),
    orElse: () => '',
  );

  if (foundFormsAuth.isEmpty) {
    return null;
  }

  final foundFormsAuthSplitted = foundFormsAuth.split('=');
  if (foundFormsAuthSplitted.length < 2) {
    return null;
  }

  return foundFormsAuthSplitted[1];
}

// Use @freezed annotation
@freezed
// Use the Mix-in
sealed class LoginResponse with _$LoginResponse {
  // Create a factory constructor with fields
  factory LoginResponse({
    String? location,
    String? date,

    // This attribute in the JSON object is named 'set-cookie'
    // But we want this set-cookie string processed
    // in function cookieAspXformAuthFromJson(), which extracts the
    // aspXFormAuth string and store this extract string in the attribute
    // called formAuth in our data object.
    @JsonKey(name: 'set-cookie', fromJson: cookieAspXformAuthFromJson)
    String? formAuth,

    // Default will return a default value if the attribute wheels does NOT
    // exist in the JSON object.
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

