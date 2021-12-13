import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'metrics_record.g.dart';

abstract class MetricsRecord
    implements Built<MetricsRecord, MetricsRecordBuilder> {
  static Serializer<MetricsRecord> get serializer => _$metricsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'wait_time')
  String get waitTime;

  @nullable
  double get sales;

  @nullable
  DateTime get timestamp;

  @nullable
  @BuiltValueField(wireName: 'pre_sub')
  double get preSub;

  @nullable
  @BuiltValueField(wireName: 'post_sub')
  double get postSub;

  @nullable
  @BuiltValueField(wireName: 'team_pick_rate')
  double get teamPickRate;

  @nullable
  @BuiltValueField(wireName: 'first_time_pickrate')
  double get firstTimePickrate;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(MetricsRecordBuilder builder) => builder
    ..waitTime = ''
    ..sales = 0.0
    ..preSub = 0.0
    ..postSub = 0.0
    ..teamPickRate = 0.0
    ..firstTimePickrate = 0.0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('metrics');

  static Stream<MetricsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  MetricsRecord._();
  factory MetricsRecord([void Function(MetricsRecordBuilder) updates]) =
      _$MetricsRecord;

  static MetricsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createMetricsRecordData({
  String waitTime,
  double sales,
  DateTime timestamp,
  double preSub,
  double postSub,
  double teamPickRate,
  double firstTimePickrate,
}) =>
    serializers.toFirestore(
        MetricsRecord.serializer,
        MetricsRecord((m) => m
          ..waitTime = waitTime
          ..sales = sales
          ..timestamp = timestamp
          ..preSub = preSub
          ..postSub = postSub
          ..teamPickRate = teamPickRate
          ..firstTimePickrate = firstTimePickrate));
