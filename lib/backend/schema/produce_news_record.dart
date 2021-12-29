import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'produce_news_record.g.dart';

abstract class ProduceNewsRecord
    implements Built<ProduceNewsRecord, ProduceNewsRecordBuilder> {
  static Serializer<ProduceNewsRecord> get serializer =>
      _$produceNewsRecordSerializer;

  @nullable
  String get mainArticle;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ProduceNewsRecordBuilder builder) =>
      builder..mainArticle = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('produce_news');

  static Stream<ProduceNewsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ProduceNewsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ProduceNewsRecord._();
  factory ProduceNewsRecord([void Function(ProduceNewsRecordBuilder) updates]) =
      _$ProduceNewsRecord;

  static ProduceNewsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createProduceNewsRecordData({
  String mainArticle,
}) =>
    serializers.toFirestore(ProduceNewsRecord.serializer,
        ProduceNewsRecord((p) => p..mainArticle = mainArticle));
