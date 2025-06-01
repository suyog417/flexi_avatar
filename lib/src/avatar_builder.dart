import '../flexi_avatar.dart';
import 'avatar_shapes.dart';

class FlexiAvatar extends StatefulWidget {
  final AvatarOptions options;

  const FlexiAvatar({Key? key, required this.options}) : super(key: key);

  @override
  State<FlexiAvatar> createState() => _FlexiAvatarState();
}

class _FlexiAvatarState extends State<FlexiAvatar> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;
  late AvatarOptions _currentOptions;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _currentOptions = widget.options;
    _controller = AnimationController(
      duration: widget.options.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.options.animationCurve,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(FlexiAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options != widget.options) {
      _controller.reset();
      _controller.forward();
      _currentOptions = oldWidget.options;
      _isLoading = widget.options.imageUrl != null;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipPath(
          clipper: _AvatarShapeClipper(widget.options.shape),
          child: _isLoading
              ? _buildLoadingIndicator()
              : _buildAnimatedAvatar(),
        );
      },
    );
  }

  Widget _buildAnimatedAvatar() {
    return FadeTransition(
      opacity: _animation,
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.95, end: 1.0).animate(_animation),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: widget.options.loadingIndicator ?? const CircularProgressIndicator(),
    );
  }

  Widget _buildContent() {
    if (widget.options.imageUrl != null) {
      return _buildImageAvatar();
    } else if (widget.options.icon != null) {
      return _buildIconAvatar();
    } else if (widget.options.name != null && widget.options.name!.isNotEmpty) {
      return _buildInitialsAvatar();
    } else {
      return _buildPatternAvatar();
    }
  }

  Widget _buildImageAvatar() {
    return ClipRRect(
      borderRadius: _getBorderRadius(),
      child: Image.network(
        widget.options.imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
      ),
    );
  }

  Widget _buildIconAvatar() {
    return Center(
      child: Icon(
        widget.options.icon,
        size: widget.options.size * 0.6,
        color: widget.options.colors.effectiveTextColor,
      ),
    );
  }

  Widget _buildInitialsAvatar() {
    final initials = _getInitials(widget.options.name!);
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          color: widget.options.colors.effectiveTextColor,
          fontSize: widget.options.size * 0.4,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPatternAvatar() {
    // Implement pattern generation
    return CustomPaint(
      painter: PatternPainter(pattern: widget.options.pattern),
    );
  }

  Widget _buildFallbackAvatar() {
    // Fallback when image fails to load
    return FlexiAvatar(
      options: widget.options.copyWith(imageUrl: null),
    );
  }

  String _getInitials(String name) {
    // Extract initials logic
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts.last[0]}'.toUpperCase();
  }

  BorderRadius _getBorderRadius() {
    return widget.options.style == AvatarStyle.circle
        ? BorderRadius.circular(widget.options.size)
        : widget.options.style == AvatarStyle.rounded
        ? BorderRadius.circular(widget.options.borderRadius)
        : BorderRadius.zero;
  }
}



class _AvatarShapeClipper extends CustomClipper<Path> {
  final AvatarShape shape;

  _AvatarShapeClipper(this.shape);

  @override
  Path getClip(Size size) => shape.getPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}