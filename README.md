
# FlexiAvatar - Flutter Avatar Generator

A highly customizable avatar generator for Flutter applications with support for multiple avatar styles, patterns, shapes, and animations.

## Features

✨ Multiple Avatar Types:

- Initials-based avatars

- Icon-based avatars

- Image avatars with fallback

- Pattern-based avatars

🎨 Customization Options:

- 7+ built-in pattern types

- Custom shapes via ClipPath

- Color and gradient support

- Size and border customization

⚡ Animation Support:

- Smooth transitions between states

- Configurable duration and curves

- Loading animations

### Installation
Add this to your package's pubspec.yaml file:
```
dependencies:
  flexi_avatar: ^1.0.0
```

### Basic Usage
Initials Avatar
```
FlexiAvatar(
  options: AvatarOptions(
    name: 'John Doe',
    colors: AvatarColors(
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    ),
  ),
)
```
Image Avatar with Fallback
```
FlexiAvatar(
  options: AvatarOptions(
    imageUrl: 'https://example.com/avatar.jpg',
    name: 'Fallback Name', // Used if image fails to load
    loadingIndicator: CircularProgressIndicator(), // Custom loading widget
  ),
)
```
Pattern Avatar
```
FlexiAvatar(
  options: AvatarOptions(
    pattern: AvatarPattern(
      type: PatternType.diagonalStripes,
      colors: [Colors.pink, Colors.purple],
    ),
  ),
)
```

### Advanced Usage

Custom Shapes
```
FlexiAvatar(
  options: AvatarOptions(
    name: 'Custom',
    shape: _CustomHeartShape(), // Your custom shape implementation
  ),
)

class _CustomHeartShape extends AvatarShape {
  @override
  Path getPath(Size size) {
    // Implement your custom path
    final path = Path();
    // ... heart shape drawing logic
    return path;
  }
}
```

Animation Configuration
```
FlexiAvatar(
  options: AvatarOptions(
    name: 'Animated',
    animationDuration: Duration(milliseconds: 500),
    animationCurve: Curves.bounceOut,
  ),
)
```

### Available Pattern Types

| Pattern Type      | Description                    |
|-------------------|--------------------------------|
| squares           | Grid of colored squares        |
| circles           | Grid of colored circles        |
| triangles         | Grid of right triangles        |
| lines             | Vertical or horizontal stripes |
| concentricCircles | Bullseye pattern               |
| diagonalStripes   | Diagonal color stripes         |
| checkerboard      | Alternating colored squares    |
| random            | Randomly selected pattern      |

### Available Shapes

| Shape Class             | Description                 |
|-------------------------|-----------------------------|
| CircleShape()           | Circular avatar (default)   |
| RoundedRectangleShape() | Avatar with rounded corners |
| TriangleShape()         | Triangular avatar           |
| StarShape()             | Star-shaped avatar          |

### Roadmap

- Add more built-in shapes

- Support for SVG custom shapes

- Avatar group/stacking

- Enhanced theming support

- More animation presets