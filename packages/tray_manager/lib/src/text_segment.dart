class TextSegment {
  final String text;
  final String? color;

  const TextSegment(this.text, {this.color});

  Map<String, dynamic> toJson() => {
    'text': text,
    'color': color,
  };
}