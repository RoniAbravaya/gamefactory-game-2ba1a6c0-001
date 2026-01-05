import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_audio/flame_audio.dart';

/// A component representing a collectible item in a platformer game.
/// It includes features like collision detection, scoring value, and optional animations.
class Collectible extends SpriteComponent with HasGameRef, Hitbox, Collidable {
  /// The score value this collectible adds to the player's score upon collection.
  final int scoreValue;

  /// The path to the sound effect to play when this collectible is collected.
  final String collectionSoundPath;

  /// Creates a new instance of a collectible item.
  ///
  /// [scoreValue] specifies the score value of the collectible.
  /// [collectionSoundPath] specifies the path to the sound effect to play upon collection.
  /// [size] specifies the size of the collectible.
  /// [position] specifies the position of the collectible in the game world.
  /// [spritePath] specifies the path to the sprite image for this collectible.
  Collectible({
    required this.scoreValue,
    required this.collectionSoundPath,
    required Vector2 position,
    required Vector2 size,
    required String spritePath,
  }) : super(position: position, size: size) {
    this.sprite = Sprite.load(spritePath);
    addShape(HitboxRectangle());
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    // Load and set the sprite for the collectible
    sprite = await Sprite.load(spritePath);
    // Optionally, setup animations here if needed
  }

  /// Handles the logic when a collectible is collected by the player.
  void collect() {
    // Play the collection sound effect
    FlameAudio.play(collectionSoundPath);
    // Implement logic to add the score value to the player's score
    // This can be done by accessing a game reference and updating the player's score

    // Remove the collectible from the game
    removeFromParent();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Check if the colliding entity is the player
    // If so, trigger the collect logic
    if (other is Player) { // Assuming there's a Player class that represents the player
      collect();
    }
  }
}