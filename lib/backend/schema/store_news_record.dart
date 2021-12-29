import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'store_news_record.g.dart';

abstract class StoreNewsRecord
    implements Built<StoreNewsRecord, StoreNewsRecordBuilder> {
  static Serializer<StoreNewsRecord> get serializer =>
      _$storeNewsRecordSerializer;

  @nullable
  String get title;

  @nullable
  String get bodyContent;

  @nullable
  String get category;

  @nullable
  String get articleImage;

  @nullable
  DateTime get datePublished;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(StoreNewsRecordBuilder builder) => builder
    ..title = ''
    ..bodyContent = ''
    ..category = ''
    ..articleImage = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('storeNews');

  static Stream<StoreNewsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<StoreNewsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  StoreNewsRecord._();
  factory StoreNewsRecord([void Function(StoreNewsRecordBuilder) updates]) =
      _$StoreNewsRecord;

  static StoreNewsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createStoreNewsRecordData({
  String title,
  String bodyContent,
  String category,
  String articleImage,
  DateTime datePublished,
}) =>
    serializers.toFirestore(
        StoreNewsRecord.serializer,
        StoreNewsRecord((s) => s
          ..title = title
          ..bodyContent = bodyContent
          ..category = category
          ..articleImage = articleImage
          ..datePublished = datePublished));
