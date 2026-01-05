import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

/// A component for the main menu scene in a platformer game.
class MenuScene extends Component with HasGameRef, Tappable {
  late final TextComponent _title;
  late final TextComponent _playButton;
  late final TextComponent _levelSelectButton;
  late final TextComponent _settingsButton;
  late final RectComponent _background;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _loadBackground();
    _loadTitle();
    _loadPlayButton();
    _loadLevelSelectButton();
    _loadSettingsButton();
  }

  void _loadBackground() {
    _background = RectComponent(
      position: Vector2.zero(),
      size: gameRef.size,
      paint: Paint()..color = Colors.lightBlueAccent,
    )..add(RectangleHitbox());
    add(_background);
  }

  void _loadTitle() {
    _title = TextComponent(
      text: 'Leap to new heights!',
      textRenderer: TextPaint(style: TextStyle(fontSize: 40, color: Colors.white, fontFamily: 'Arial')),
      position: Vector2(gameRef.size.x / 2 - 100, gameRef.size.y / 4),
      anchor: Anchor.topLeft,
    );
    add(_title);
  }

  void _loadPlayButton() {
    _playButton = TextComponent(
      text: 'Play',
      textRenderer: TextPaint(style: TextStyle(fontSize: 30, color: Colors.green, fontFamily: 'Arial')),
      position: Vector2(gameRef.size.x / 2 - 50, gameRef.size.y / 2),
      anchor: Anchor.topLeft,
    )..add(RectangleHitbox());
    _playButton.add(TapGestureRecognizer()..onTapDown = (details) => _onPlayPressed());
    add(_playButton);
  }

  void _loadLevelSelectButton() {
    _levelSelectButton = TextComponent(
      text: 'Levels',
      textRenderer: TextPaint(style: TextStyle(fontSize: 30, color: Colors.blue, fontFamily: 'Arial')),
      position: Vector2(gameRef.size.x / 2 - 50, gameRef.size.y / 2 + 50),
      anchor: Anchor.topLeft,
    )..add(RectangleHitbox());
    _levelSelectButton.add(TapGestureRecognizer()..onTapDown = (details) => _onLevelSelectPressed());
    add(_levelSelectButton);
  }

  void _loadSettingsButton() {
    _settingsButton = TextComponent(
      text: 'Settings',
      textRenderer: TextPaint(style: TextStyle(fontSize: 30, color: Colors.purple, fontFamily: 'Arial')),
      position: Vector2(gameRef.size.x / 2 - 50, gameRef.size.y / 2 + 100),
      anchor: Anchor.topLeft,
    )..add(RectangleHitbox());
    _settingsButton.add(TapGestureRecognizer()..onTapDown = (details) => _onSettingsPressed());
    add(_settingsButton);
  }

  void _onPlayPressed() {
    // Implement navigation to the game play scene
    print('Play button pressed');
  }

  void _onLevelSelectPressed() {
    // Implement navigation to the level select scene
    print('Level select button pressed');
  }

  void _onSettingsPressed() {
    // Implement navigation to the settings scene
    print('Settings button pressed');
  }

  @override
  bool onTapDown(TapDownInfo info) {
    // Implement tap functionality for each button
    return super.onTapDown(info);
  }
}