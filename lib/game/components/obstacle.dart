import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

/// A component representing an obstacle in a platformer game.
///
/// It includes a visual representation, collision detection, and can deal damage to the player on contact.
class Obstacle extends PositionComponent with HasHitboxes, Collidable {
  final Vector2 _size;
  final String _spritePath;
  final double _movementSpeed;
  bool _isMoving;
  Vector2 _movementDirection;

  /// Creates a new obstacle.
  ///
  /// [size] specifies the size of the obstacle.
  /// [spritePath] is the path to the sprite image.
  /// [movementSpeed] determines how fast the obstacle moves.
  /// [isMoving] indicates whether the obstacle is stationary or moving.
  /// [movementDirection] specifies the direction of movement if the obstacle is moving.
  Obstacle({
    required Vector2 size,
    required String spritePath,
    double movementSpeed = 0,
    bool isMoving = false,
    Vector2? movementDirection,
  })  : _size = size,
        _spritePath = spritePath,
        _movementSpeed = movementSpeed,
        _isMoving = isMoving,
        _movementDirection = movementDirection ?? Vector2.zero() {
    addHitbox(HitboxRectangle(relation: size));
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = _size;
    if (_spritePath.isNotEmpty) {
      sprite = await Sprite.load(_spritePath);
    } else {
      // Fallback to a simple shape if no sprite path is provided.
      paint = Paint()..color = const Color(0xFFFF0000);
    }
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isMoving && _movementSpeed > 0) {
      position += _movementDirection.normalized() * _movementSpeed * dt;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Handle collision effects, like dealing damage to the player.
  }
}