import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'items_record.g.dart';

abstract class ItemsRecord implements Built<ItemsRecord, ItemsRecordBuilder> {
  static Serializer<ItemsRecord> get serializer => _$itemsRecordSerializer;

  @nullable
  DocumentReference get user;

  @nullable
  String get category;

  @nullable
  String get gender;

  @nullable
  @BuiltValueField(wireName: 'time_posted')
  DateTime get timePosted;

  @nullable
  String get condition;

  @nullable
  String get photo;

  @nullable
  String get color;

  @nullable
  double get price;

  @nullable
  @BuiltValueField(wireName: 'item_name')
  String get itemName;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ItemsRecordBuilder builder) => builder
    ..category = ''
    ..gender = ''
    ..condition = ''
    ..photo = ''
    ..color = ''
    ..price = 0.0
    ..itemName = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('items');

  static Stream<ItemsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ItemsRecord._();
  factory ItemsRecord([void Function(ItemsRecordBuilder) updates]) =
      _$ItemsRecord;

  static ItemsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createItemsRecordData({
  DocumentReference user,
  String category,
  String gender,
  DateTime timePosted,
  String condition,
  String photo,
  String color,
  double price,
  String itemName,
}) =>
    serializers.toFirestore(
        ItemsRecord.serializer,
        ItemsRecord((i) => i
          ..user = user
          ..category = category
          ..gender = gender
          ..timePosted = timePosted
          ..condition = condition
          ..photo = photo
          ..color = color
          ..price = price
          ..itemName = itemName));
