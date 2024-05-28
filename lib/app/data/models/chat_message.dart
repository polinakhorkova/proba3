import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:proba3/app/data/socket_event.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {

  factory ChatMessage({
    required String clientId,
    required String username,
    @Default('') String message,
    @Default(SocketEvent.unknown) SocketEvent type
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
}