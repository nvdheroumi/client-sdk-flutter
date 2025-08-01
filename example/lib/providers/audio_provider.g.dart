// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$microphoneEnabledHash() => r'd4f7a9c2e5b8d1f4a7c9e2b5d8f1a4c7e9b2d5f8';

/// See also [microphoneEnabled].
@ProviderFor(microphoneEnabled)
final microphoneEnabledProvider = AutoDisposeProvider<bool>.internal(
  microphoneEnabled,
  name: r'microphoneEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$microphoneEnabledHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MicrophoneEnabledRef = AutoDisposeProviderRef<bool>;
String _$audioInputDevicesHash() => r'e5a8c1f4b7e9d2a5c8f1b4e7a9c2f5d8a1c4f7e9';

/// See also [audioInputDevices].
@ProviderFor(audioInputDevices)
final audioInputDevicesProvider = AutoDisposeProvider<List<MediaDevice>>.internal(
  audioInputDevices,
  name: r'audioInputDevicesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioInputDevicesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AudioInputDevicesRef = AutoDisposeProviderRef<List<MediaDevice>>;
String _$audioOutputDevicesHash() => r'f6b9d2e5a8c1f4b7e9d2a5c8f1b4e7a9c2f5d8a1';

/// See also [audioOutputDevices].
@ProviderFor(audioOutputDevices)
final audioOutputDevicesProvider = AutoDisposeProvider<List<MediaDevice>>.internal(
  audioOutputDevices,
  name: r'audioOutputDevicesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioOutputDevicesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AudioOutputDevicesRef = AutoDisposeProviderRef<List<MediaDevice>>;
String _$speakerphoneOnHash() => r'a7c9e2b5d8f1a4c7e9b2d5f8a1c4f7e9b2d5f8a1';

/// See also [speakerphoneOn].
@ProviderFor(speakerphoneOn)
final speakerphoneOnProvider = AutoDisposeProvider<bool>.internal(
  speakerphoneOn,
  name: r'speakerphoneOnProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$speakerphoneOnHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SpeakerphoneOnRef = AutoDisposeProviderRef<bool>;
String _$selectedAudioInputHash() => r'b8d1f4a7c9e2b5d8f1a4c7e9b2d5f8a1c4f7e9b2';

/// See also [selectedAudioInput].
@ProviderFor(selectedAudioInput)
final selectedAudioInputProvider = AutoDisposeProvider<MediaDevice?>.internal(
  selectedAudioInput,
  name: r'selectedAudioInputProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedAudioInputHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectedAudioInputRef = AutoDisposeProviderRef<MediaDevice?>;
String _$selectedAudioOutputHash() => r'c9e2b5d8f1a4c7e9b2d5f8a1c4f7e9b2d5f8a1c4';

/// See also [selectedAudioOutput].
@ProviderFor(selectedAudioOutput)
final selectedAudioOutputProvider = AutoDisposeProvider<MediaDevice?>.internal(
  selectedAudioOutput,
  name: r'selectedAudioOutputProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedAudioOutputHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectedAudioOutputRef = AutoDisposeProviderRef<MediaDevice?>;
String _$isParticipantSpeakingHash() => r'd1f4a7c9e2b5d8f1a4c7e9b2d5f8a1c4f7e9b2d5';

/// See also [isParticipantSpeaking].
@ProviderFor(isParticipantSpeaking)
final isParticipantSpeakingProvider = AutoDisposeProviderFamily<bool, Participant>.internal(
  isParticipantSpeaking,
  name: r'isParticipantSpeakingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isParticipantSpeakingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsParticipantSpeakingRef = AutoDisposeProviderRef<bool>;
String _$audioDeviceNotifierHash() => r'e2a5c8f1b4e7a9c2f5d8a1c4f7e9b2d5f8a1c4f7';

/// See also [AudioDeviceNotifier].
@ProviderFor(AudioDeviceNotifier)
final audioDeviceNotifierProvider =
    AutoDisposeNotifierProvider<AudioDeviceNotifier, AudioDeviceState>.internal(
  AudioDeviceNotifier.new,
  name: r'audioDeviceNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioDeviceNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AudioDeviceNotifier = AutoDisposeNotifier<AudioDeviceState>;
String _$voiceSettingsNotifierHash() => r'f3b6d9a2e5c8f1b4e7a9c2f5d8a1c4f7e9b2d5f8';

/// See also [VoiceSettingsNotifier].
@ProviderFor(VoiceSettingsNotifier)
final voiceSettingsNotifierProvider =
    AutoDisposeNotifierProvider<VoiceSettingsNotifier, VoiceSettings>.internal(
  VoiceSettingsNotifier.new,
  name: r'voiceSettingsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$voiceSettingsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VoiceSettingsNotifier = AutoDisposeNotifier<VoiceSettings>;
String _$audioQualityNotifierHash() => r'a4c7e9b2d5f8a1c4f7e9b2d5f8a1c4f7e9b2d5f8';

/// See also [AudioQualityNotifier].
@ProviderFor(AudioQualityNotifier)
final audioQualityNotifierProvider =
    AutoDisposeNotifierProvider<AudioQualityNotifier, Map<String, double>>.internal(
  AudioQualityNotifier.new,
  name: r'audioQualityNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioQualityNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AudioQualityNotifier = AutoDisposeNotifier<Map<String, double>>;
String _$audioControlNotifierHash() => r'b5d8a1c4f7e9b2d5f8a1c4f7e9b2d5f8a1c4f7e9';

/// See also [AudioControlNotifier].
@ProviderFor(AudioControlNotifier)
final audioControlNotifierProvider =
    AutoDisposeNotifierProvider<AudioControlNotifier, bool>.internal(
  AudioControlNotifier.new,
  name: r'audioControlNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$audioControlNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AudioControlNotifier = AutoDisposeNotifier<bool>;