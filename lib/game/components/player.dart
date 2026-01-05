import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

/// Represents the player character in the platformer game.
class Player extends SpriteAnimationComponent with HasGameRef, Hitbox, Collidable {
  static const double gravity = 800; // Pixels per second squared.
  static const double jumpSpeed = -350; // Initial speed at the start of a jump, pixels per second.
  static const int invulnerabilityTime = 2000; // Milliseconds of invulnerability after being hit.

  double ySpeed = 0; // Vertical speed, pixels per second.
  bool onGround = false; // Is the player on the ground?
  bool isInvulnerable = false; // Is the player currently invulnerable?
  DateTime lastHitTime; // Last time the player was hit.

  Player(Vector2 position, Vector2 size)
      : super(position: position, size: size, anchor: Anchor.center) {
    addHitbox(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final spriteSheet = await gameRef.images.load('player_spritesheet.png');
    final spriteSize = Vector2(48, 48);
    animation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: spriteSize,
        loop: true,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    ySpeed += gravity * dt;
    position.add(Vector2(0, ySpeed * dt));

    // Check for landing on the ground.
    if (position.y > gameRef.size.y - size.y / 2) {
      position.y = gameRef.size.y - size.y / 2;
      ySpeed = 0;
      onGround = true;
    }

    // Handle invulnerability duration.
    if (isInvulnerable && DateTime.now().difference(lastHitTime).inMilliseconds > invulnerabilityTime) {
      isInvulnerable = false;
    }
  }

  /// Makes the player jump if they are on the ground.
  void jump() {
    if (onGround) {
      ySpeed = jumpSpeed;
      onGround = false;
    }
  }

  /// Handles collision with other [Collidable] objects.
  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Obstacle && !isInvulnerable) {
      takeDamage();
    } else if (other is Collectible) {
      collectItem(other);
    }
  }

  /// Reduces the player's health and triggers invulnerability.
  void takeDamage() {
    // Implement health reduction and invulnerability logic here.
    isInvulnerable = true;
    lastHitTime = DateTime.now();
    // Placeholder for health reduction logic.
  }

  /// Collects the specified [Collectible] item.
  void collectItem(Collectible item) {
    // Implement item collection logic here.
    // Placeholder for collectible logic.
  }
}

/// Represents an obstacle in the game.
class Obstacle extends SpriteComponent with Hitbox, Collidable {
  Obstacle(Vector2 position, Vector2 size, Sprite sprite)
      : super(position: position, size: size, sprite: sprite) {
    addHitbox(HitboxRectangle());
  }
}

/// Represents a collectible item in the game.
class Collectible extends SpriteComponent with Hitbox, Collidable {
  Collectible(Vector2 position, Vector2 size, Sprite sprite)
      : super(position: position, size: size, sprite: sprite) {
    addHitbox(HitboxRectangle());
  }
}