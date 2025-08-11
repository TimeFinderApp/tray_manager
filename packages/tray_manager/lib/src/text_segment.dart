class TextSegment {
  final String text;
  final String? color;
  final bool useMonospacedFont;

  const TextSegment(
    this.text, {
    this.color,
    this.useMonospacedFont = false,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'color': color,
        'useMonospacedFont': useMonospacedFont,
      };
}