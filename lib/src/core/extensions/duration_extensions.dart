extension CustomDurationExtension on Duration? {
  bool get isOver =>
      this == null || (this?.isNegative ?? false) || this == Duration.zero;
  bool get isNotOver => !isOver;
}
