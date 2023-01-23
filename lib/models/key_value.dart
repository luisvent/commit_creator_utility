import 'dart:convert';

List<KeyValue> keyValueFromJson(List obj) =>
    List<KeyValue>.from(obj.map((x) => KeyValue.fromJson(x)));

String keyValueToJson(List<KeyValue> data) =>
    json.encode(List<String>.from(data.map((x) => x.toJson())));

class KeyValue {
  KeyValue({
    required this.key,
    required this.value,
  });

  String key;
  String value;

  factory KeyValue.fromJson(Map<String, dynamic> json) => KeyValue(
        key: json["key"]!,
        value: json["value"]!,
      );

  Map<String, String> toJson() => {
        "key": key,
        "value": value,
      };
}
