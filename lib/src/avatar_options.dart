import '../flexi_avatar.dart';
import 'avatar_shapes.dart';

class AvatarOptions {
  final String? name; // For initials
  final String? imageUrl; // For custom image
  final IconData? icon; // For icon avatars
  final AvatarStyle style;
  final AvatarColors colors;
  final double size;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final AvatarPattern? pattern;
  final AvatarShape shape;
  final Duration animationDuration;
  final Curve animationCurve;
  final Widget? loadingIndicator;

  const AvatarOptions({
    this.name,
    this.imageUrl,
    this.icon,
    this.style = AvatarStyle.circle,
    this.colors = const AvatarColors(),
    this.size = 48.0,
    this.borderRadius = 8.0,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.pattern,
    this.shape = const CircleShape(),
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.loadingIndicator,
  });

  AvatarOptions copyWith({
    String? name,
    String? imageUrl,
    IconData? icon,
    AvatarStyle? style,
    AvatarColors? colors,
    double? size,
    double? borderRadius,
    double? borderWidth,
    Color? borderColor,
    AvatarPattern? pattern,
     AvatarShape? shape,
     Duration? animationDuration,
     Curve? animationCurve,
     Widget? loadingIndicator,
  }) {
    return AvatarOptions(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      icon: icon ?? this.icon,
      style: style ?? this.style,
      colors: colors ?? this.colors,
      size: size ?? this.size,
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      borderColor: borderColor ?? this.borderColor,
      pattern: pattern ?? this.pattern,
      animationCurve: animationCurve ?? this.animationCurve,
      animationDuration: animationDuration ?? this.animationDuration,
      loadingIndicator: loadingIndicator ?? this.loadingIndicator,
      shape: shape ?? this.shape
    );
  }
}