Install flutter_lints if you don't have it

In analysis_options.yaml, add:

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    # These rules are typically enabled by default in flutter_lints, 
    # but you can explicitly list them if needed:
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    # unnecessary_const warns you if you add a const where it is not needed
    unnecessary_const: true
```
