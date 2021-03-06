// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HOTPToken _$HOTPTokenFromJson(Map<String, dynamic> json) {
  return HOTPToken(
    label: json['label'] as String,
    issuer: json['issuer'] as String,
    id: json['id'] as String,
    algorithm: _$enumDecodeNullable(_$AlgorithmsEnumMap, json['algorithm']),
    digits: json['digits'] as int,
    secret: json['secret'] as String,
    counter: json['counter'] as int,
  )..type = json['type'] as String;
}

Map<String, dynamic> _$HOTPTokenToJson(HOTPToken instance) => <String, dynamic>{
      'type': instance.type,
      'label': instance.label,
      'id': instance.id,
      'issuer': instance.issuer,
      'algorithm': _$AlgorithmsEnumMap[instance.algorithm],
      'digits': instance.digits,
      'secret': instance.secret,
      'counter': instance.counter,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$AlgorithmsEnumMap = {
  Algorithms.SHA1: 'SHA1',
  Algorithms.SHA256: 'SHA256',
  Algorithms.SHA512: 'SHA512',
};

TOTPToken _$TOTPTokenFromJson(Map<String, dynamic> json) {
  return TOTPToken(
    label: json['label'] as String,
    issuer: json['issuer'] as String,
    id: json['id'] as String,
    algorithm: _$enumDecodeNullable(_$AlgorithmsEnumMap, json['algorithm']),
    digits: json['digits'] as int,
    secret: json['secret'] as String,
    period: json['period'] as int,
  )..type = json['type'] as String;
}

Map<String, dynamic> _$TOTPTokenToJson(TOTPToken instance) => <String, dynamic>{
      'type': instance.type,
      'label': instance.label,
      'id': instance.id,
      'issuer': instance.issuer,
      'algorithm': _$AlgorithmsEnumMap[instance.algorithm],
      'digits': instance.digits,
      'secret': instance.secret,
      'period': instance.period,
    };

PushToken _$PushTokenFromJson(Map<String, dynamic> json) {
  return PushToken(
    label: json['label'] as String,
    serial: json['serial'] as String,
    issuer: json['issuer'] as String,
    id: json['id'] as String,
    sslVerify: json['sslVerify'] as bool,
    enrollmentCredentials: json['enrollmentCredentials'] as String,
    url: json['url'] == null ? null : Uri.parse(json['url'] as String),
    expirationDate: json['expirationDate'] == null
        ? null
        : DateTime.parse(json['expirationDate'] as String),
  )
    ..type = json['type'] as String
    ..isRolledOut = json['isRolledOut'] as bool
    ..publicServerKey = json['publicServerKey'] as String
    ..privateTokenKey = json['privateTokenKey'] as String
    ..publicTokenKey = json['publicTokenKey'] as String
    ..pushRequests = json['pushRequests'] == null
        ? null
        : PushRequestQueue.fromJson(
            json['pushRequests'] as Map<String, dynamic>)
    ..knownPushRequests = json['knownPushRequests'] == null
        ? null
        : CustomIntBuffer.fromJson(
            json['knownPushRequests'] as Map<String, dynamic>);
}

Map<String, dynamic> _$PushTokenToJson(PushToken instance) => <String, dynamic>{
      'type': instance.type,
      'label': instance.label,
      'id': instance.id,
      'issuer': instance.issuer,
      'url': instance.url?.toString(),
      'isRolledOut': instance.isRolledOut,
      'publicServerKey': instance.publicServerKey,
      'privateTokenKey': instance.privateTokenKey,
      'publicTokenKey': instance.publicTokenKey,
      'serial': instance.serial,
      'sslVerify': instance.sslVerify,
      'enrollmentCredentials': instance.enrollmentCredentials,
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'pushRequests': instance.pushRequests,
      'knownPushRequests': instance.knownPushRequests,
    };

PushRequest _$PushRequestFromJson(Map<String, dynamic> json) {
  return PushRequest(
    title: json['title'] as String,
    question: json['question'] as String,
    uri: json['uri'] == null ? null : Uri.parse(json['uri'] as String),
    nonce: json['nonce'] as String,
    sslVerify: json['sslVerify'] as bool,
    id: json['id'] as int,
    expirationDate: json['expirationDate'] == null
        ? null
        : DateTime.parse(json['expirationDate'] as String),
  );
}

Map<String, dynamic> _$PushRequestToJson(PushRequest instance) =>
    <String, dynamic>{
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'id': instance.id,
      'nonce': instance.nonce,
      'sslVerify': instance.sslVerify,
      'uri': instance.uri?.toString(),
      'question': instance.question,
      'title': instance.title,
    };

PushRequestQueue _$PushRequestQueueFromJson(Map<String, dynamic> json) {
  return PushRequestQueue()
    ..list = (json['list'] as List)
        ?.map((e) =>
            e == null ? null : PushRequest.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PushRequestQueueToJson(PushRequestQueue instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

SerializableRSAPublicKey _$SerializableRSAPublicKeyFromJson(
    Map<String, dynamic> json) {
  return SerializableRSAPublicKey(
    json['modulus'] == null ? null : BigInt.parse(json['modulus'] as String),
    json['exponent'] == null ? null : BigInt.parse(json['exponent'] as String),
  );
}

Map<String, dynamic> _$SerializableRSAPublicKeyToJson(
        SerializableRSAPublicKey instance) =>
    <String, dynamic>{
      'modulus': instance.modulus?.toString(),
      'exponent': instance.exponent?.toString(),
    };

SerializableRSAPrivateKey _$SerializableRSAPrivateKeyFromJson(
    Map<String, dynamic> json) {
  return SerializableRSAPrivateKey(
    json['modulus'] == null ? null : BigInt.parse(json['modulus'] as String),
    json['exponent'] == null ? null : BigInt.parse(json['exponent'] as String),
    json['p'] == null ? null : BigInt.parse(json['p'] as String),
    json['q'] == null ? null : BigInt.parse(json['q'] as String),
  );
}

Map<String, dynamic> _$SerializableRSAPrivateKeyToJson(
        SerializableRSAPrivateKey instance) =>
    <String, dynamic>{
      'modulus': instance.modulus?.toString(),
      'exponent': instance.exponent?.toString(),
      'p': instance.p?.toString(),
      'q': instance.q?.toString(),
    };

CustomIntBuffer _$CustomIntBufferFromJson(Map<String, dynamic> json) {
  return CustomIntBuffer()
    ..list = (json['list'] as List)?.map((e) => e as int)?.toList();
}

Map<String, dynamic> _$CustomIntBufferToJson(CustomIntBuffer instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
