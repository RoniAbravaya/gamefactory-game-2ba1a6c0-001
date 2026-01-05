import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';

/// Represents the player in a platformer game, handling movement, animations, and interactions.
class Player extends SpriteAnimationComponent
    with HasGameRef, Hitbox, Collidable, KeyboardHandler {
  Vector2 velocity = Vector2.zero();
  final double gravity = 800;
  final double jumpSpeed = -350;
  bool onGround = false;

  // Player states
  late SpriteAnimation idleAnimation;
  late SpriteAnimation movingAnimation;
  late SpriteAnimation jumpingAnimation;

  // Player properties
  int lives = 3;
  int score = 0;

  Player()
      : super(size: Vector2(48, 48), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations();
    animation = idleAnimation;
    addHitbox(HitboxRectangle());
  }

  /// Loads all animations for the player.
  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('player_spritesheet.png'),
      srcSize: Vector2(48, 48),
    );
    idleAnimation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 4);
    movingAnimation = spriteSheet.createAnimation(row: 1, stepTime: 0.1, to: 4);
    jumpingAnimation = spriteSheet.createAnimation(row: 2, stepTime: 0.1, to: 4);
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity.y += gravity * dt;
    position += velocity * dt;

    if (position.y > gameRef.size.y) {
      onDied();
    }

    // Update animation based on the player's state
    if (!onGround) {
      animation = jumpingAnimation;
    } else if (velocity.x != 0) {
      animation = movingAnimation;
    } else {
      animation = idleAnimation;
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    if (keysPressed.contains(LogicalKeyboardKey.space) && isKeyDown && onGround) {
      velocity.y = jumpSpeed;
      onGround = false;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  /// Called when the player collides with the ground.
  void onLand() {
    onGround = true;
    velocity.y = 0;
  }

  /// Called when the player dies (loses all lives or falls off the map).
  void onDied() {
    lives--;
    if (lives <= 0) {
      // Handle game over logic here
    } else {
      // Reset player position or handle life loss
    }
  }

  /// Increases the player's score.
  void increaseScore(int points) {
    score += points;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Handle collision with platforms, enemies, and collectibles here
  }
}