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
  @BuiltValueField(wireName: 'pre_sub')
  int get preSub;

  @nullable
  @BuiltValueField(wireName: 'post_sub')
  int get postSub;

  @nullable
  double get sales;

  @nullable
  @BuiltValueField(wireName: 'first_time_pickrate')
  int get firstTimePickrate;

  @nullable
  @BuiltValueField(wireName: 'team_pick_rate')
  int get teamPickRate;

  @nullable
  DateTime get timestamp;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(MetricsRecordBuilder builder) => builder
    ..waitTime = ''
    ..preSub = 0
    ..postSub = 0
    ..sales = 0.0
    ..firstTimePickrate = 0
    ..teamPickRate = 0;

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
  int preSub,
  int postSub,
  double sales,
  int firstTimePickrate,
  int teamPickRate,
  DateTime timestamp,
}) =>
    serializers.toFirestore(
        MetricsRecord.serializer,
        MetricsRecord((m) => m
          ..waitTime = waitTime
          ..preSub = preSub
          ..postSub = postSub
          ..sales = sales
          ..firstTimePickrate = firstTimePickrate
          ..teamPickRate = teamPickRate
          ..timestamp = timestamp));
