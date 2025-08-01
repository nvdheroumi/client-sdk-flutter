# LiveKit Voice App - Riverpod Refactor

## Overview

This document outlines the comprehensive refactor of the LiveKit voice application from Provider to Riverpod state management. The refactor introduces a clean, reactive architecture with specialized providers for voice chat functionality.

## Architecture Overview

### Provider Structure

The application now uses a layered provider architecture:

```
├── providers/
│   ├── room_provider.dart          # Room connection and state management
│   ├── participant_provider.dart   # Participant tracking and controls
│   ├── audio_provider.dart         # Audio device and settings management
│   └── voice_provider.dart         # Voice chat specific features
```

### Key Benefits

- **Reactive UI**: Automatic UI updates when state changes
- **Better Separation of Concerns**: Each provider handles specific domain logic
- **Improved Performance**: Granular state updates and automatic disposal
- **Type Safety**: Strong typing with code generation
- **Testability**: Easy to test individual providers in isolation

## Provider Details

### 1. Room Provider (`room_provider.dart`)

Manages room connection state and participant tracking.

**Key Features:**
- Room connection management
- Connection state tracking (connecting, connected, reconnecting, failed)
- Participant track management
- Recording state monitoring

**Main Providers:**
```dart
// Current room instance
final currentRoomProvider = Provider<Room?>;

// Connection state
final connectionStateProvider = Provider<RoomConnectionState>;

// List of participant tracks for UI rendering
final participantTracksProvider = Provider<List<ParticipantTrack>>;

// Recording status
final isRecordingProvider = Provider<bool>;
```

### 2. Participant Provider (`participant_provider.dart`)

Handles participant-specific state and controls.

**Key Features:**
- Local and remote participant management
- Individual participant track states
- Participant controls (mute, video, screen share)
- Connection quality monitoring

**Main Providers:**
```dart
// All participants in the room
final allParticipantsProvider = Provider<List<Participant>>;

// Local participant controls
final localParticipantControlsNotifierProvider = NotifierProvider<LocalParticipantControlsNotifier, Map<String, bool>>;

// Participant by identity lookup
final participantByIdentityProvider = ProviderFamily<Participant?, String>;

// Audio/Video track providers for each participant
final participantAudioTrackProvider = ProviderFamily<AudioTrack?, String>;
final participantVideoTrackProvider = ProviderFamily<VideoTrack?, String>;
```

### 3. Audio Provider (`audio_provider.dart`)

Manages audio devices and voice processing settings.

**Key Features:**
- Audio input/output device enumeration
- Device selection and switching
- Speakerphone control
- Voice processing settings (echo cancellation, noise suppression, etc.)
- Microphone volume control

**Main Providers:**
```dart
// Audio device management
final audioDeviceNotifierProvider = NotifierProvider<AudioDeviceNotifier, AudioDeviceState>;

// Voice settings
final voiceSettingsNotifierProvider = NotifierProvider<VoiceSettingsNotifier, VoiceSettings>;

// Device lists
final audioInputDevicesProvider = Provider<List<MediaDevice>>;
final audioOutputDevicesProvider = Provider<List<MediaDevice>>;
```

### 4. Voice Provider (`voice_provider.dart`)

Specialized voice chat features and advanced voice controls.

**Key Features:**
- Voice chat modes (Open Mic, Push-to-Talk, Voice Activated)
- Voice activity detection
- Push-to-talk functionality
- Voice quality monitoring
- Speaking participant tracking
- Voice chat room controls

**Main Providers:**
```dart
// Voice chat settings
final voiceChatSettingsNotifierProvider = NotifierProvider<VoiceChatSettingsNotifier, VoiceChatSettings>;

// Voice activity detection
final voiceActivityNotifierProvider = NotifierProvider<VoiceActivityNotifier, Map<String, VoiceActivity>>;

// Push-to-talk control
final pushToTalkNotifierProvider = NotifierProvider<PushToTalkNotifier, bool>;

// Current speakers
final currentSpeakersProvider = Provider<List<String>>;
```

## Voice Chat Features

### Voice Chat Modes

The application supports three voice chat modes:

1. **Open Mic**: Always listening, microphone stays enabled
2. **Push-to-Talk**: Press and hold to speak
3. **Voice Activated**: Automatic speaking detection based on audio levels

```dart
// Change voice chat mode
ref.read(voiceChatSettingsNotifierProvider.notifier).updateMode(VoiceChatMode.pushToTalk);
```

### Push-to-Talk

When in push-to-talk mode, users can control their microphone:

```dart
// Start talking
ref.read(pushToTalkNotifierProvider.notifier).startTalking();

// Stop talking
ref.read(pushToTalkNotifierProvider.notifier).stopTalking();
```

### Voice Activity Detection

Real-time voice activity monitoring:

```dart
// Check if a participant is speaking
final isSpeaking = ref.watch(isParticipantSpeakingVoiceProvider(participantId));

// Get current speakers list
final speakers = ref.watch(currentSpeakersProvider);

// Get audio level for a participant
final audioLevel = ref.watch(participantAudioLevelProvider(participantId));
```

### Voice Processing Settings

Advanced audio processing controls:

```dart
final voiceNotifier = ref.read(voiceChatSettingsNotifierProvider.notifier);

// Toggle noise suppression
voiceNotifier.toggleNoiseSuppression();

// Toggle echo cancellation
voiceNotifier.toggleEchoCancellation();

// Toggle auto gain control
voiceNotifier.toggleAutoGainControl();

// Enable spatial audio
voiceNotifier.toggleSpatialAudio();
```

## UI Integration

### Reactive UI Updates

The UI automatically updates when state changes:

```dart
class VoiceControlsWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch providers for automatic updates
    final voiceSettings = ref.watch(voiceChatSettingsNotifierProvider);
    final currentSpeakers = ref.watch(currentSpeakersProvider);
    final pushToTalkState = ref.watch(pushToTalkNotifierProvider);
    
    return Column(
      children: [
        // Voice mode indicator
        Text('Mode: ${voiceSettings.mode.name}'),
        
        // Speaking indicators
        if (currentSpeakers.isNotEmpty)
          Text('Speaking: ${currentSpeakers.join(', ')}'),
        
        // Push-to-talk button
        if (voiceSettings.mode == VoiceChatMode.pushToTalk)
          GestureDetector(
            onTapDown: (_) => ref.read(pushToTalkNotifierProvider.notifier).startTalking(),
            onTapUp: (_) => ref.read(pushToTalkNotifierProvider.notifier).stopTalking(),
            child: Container(
              color: pushToTalkState ? Colors.red : Colors.grey,
              child: Text('Push to Talk'),
            ),
          ),
      ],
    );
  }
}
```

### Audio Device Selection

```dart
class AudioDeviceSelector extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioInputs = ref.watch(audioInputDevicesProvider);
    final selectedInput = ref.watch(selectedAudioInputProvider);
    
    return PopupMenuButton<MediaDevice>(
      onSelected: (device) {
        ref.read(audioDeviceNotifierProvider.notifier).selectAudioInput(device);
      },
      itemBuilder: (context) => audioInputs
          .map((device) => PopupMenuItem(
                value: device,
                child: ListTile(
                  leading: Icon(
                    selectedInput?.deviceId == device.deviceId
                        ? Icons.check_circle
                        : Icons.mic,
                  ),
                  title: Text(device.label),
                ),
              ))
          .toList(),
    );
  }
}
```

## Migration Guide

### From Provider to Riverpod

1. **Wrap the app with ProviderScope**:
```dart
runApp(
  ProviderScope(
    child: MyApp(),
  ),
);
```

2. **Convert StatefulWidget to ConsumerStatefulWidget**:
```dart
// Before
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// After
class MyWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MyWidget> {
  @override
  Widget build(BuildContext context) {
    // Access providers via ref
    final roomState = ref.watch(roomNotifierProvider);
    return Container();
  }
}
```

3. **Replace Provider.of with ref.watch/read**:
```dart
// Before
final room = Provider.of<Room>(context);

// After
final room = ref.watch(currentRoomProvider);
```

## Performance Considerations

### Provider Granularity

The refactor uses fine-grained providers to minimize unnecessary rebuilds:

- **Room-level changes** only trigger room-related UI updates
- **Participant-specific changes** only affect that participant's UI
- **Audio settings changes** only update audio controls
- **Voice activity changes** only update speaking indicators

### Automatic Disposal

Riverpod automatically disposes providers when no longer needed, preventing memory leaks.

### Efficient Updates

State changes are batched and optimized, reducing the number of UI rebuilds.

## Testing

### Provider Testing

Each provider can be tested in isolation:

```dart
test('voice chat mode changes correctly', () {
  final container = ProviderContainer();
  
  // Initial state
  expect(
    container.read(voiceChatSettingsNotifierProvider).mode,
    VoiceChatMode.openMic,
  );
  
  // Change mode
  container.read(voiceChatSettingsNotifierProvider.notifier)
    .updateMode(VoiceChatMode.pushToTalk);
  
  // Verify change
  expect(
    container.read(voiceChatSettingsNotifierProvider).mode,
    VoiceChatMode.pushToTalk,
  );
});
```

### Widget Testing

Test widgets with provider overrides:

```dart
testWidgets('voice controls display correctly', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        voiceChatSettingsNotifierProvider.overrideWith(
          () => MockVoiceChatSettingsNotifier(),
        ),
      ],
      child: VoiceControlsWidget(),
    ),
  );
  
  expect(find.text('Mode: pushToTalk'), findsOneWidget);
});
```

## Future Enhancements

### Planned Features

1. **Voice Commands**: Voice-activated controls
2. **Audio Filters**: Real-time audio effects
3. **Voice Analytics**: Speaking time tracking
4. **Custom Voice Profiles**: User-specific voice settings
5. **Voice Chat Rooms**: Multiple voice channels
6. **Voice Recording**: Session recording capabilities

### Architecture Extensions

1. **Persistence Layer**: Save voice settings locally
2. **Network Layer**: Voice chat server integration
3. **Analytics Layer**: Voice usage metrics
4. **Plugin System**: Extensible voice features

## Conclusion

The Riverpod refactor provides a solid foundation for advanced voice chat features while maintaining clean, reactive architecture. The modular provider system makes it easy to extend functionality and maintain code quality as the application grows.

The new architecture supports:
- ✅ Real-time voice activity detection
- ✅ Multiple voice chat modes
- ✅ Advanced audio processing
- ✅ Granular state management
- ✅ Reactive UI updates
- ✅ Easy testing and maintenance

This refactor sets the stage for building sophisticated voice chat applications with LiveKit and Flutter.