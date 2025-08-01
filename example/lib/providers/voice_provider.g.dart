// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isParticipantSpeakingVoiceHash() => r'b5e8a1c4f7b9e2a5d8c1f4b7e9a2d5c8f1b4e7a9';

/// See also [isParticipantSpeakingVoice].
@ProviderFor(isParticipantSpeakingVoice)
final isParticipantSpeakingVoiceProvider = AutoDisposeProviderFamily<bool, String>.internal(
  isParticipantSpeakingVoice,
  name: r'isParticipantSpeakingVoiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isParticipantSpeakingVoiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsParticipantSpeakingVoiceRef = AutoDisposeProviderRef<bool>;
String _$participantAudioLevelHash() => r'c6f9b2e5a8d1c4f7b9e2a5d8c1f4b7e9a2d5c8f1';

/// See also [participantAudioLevel].
@ProviderFor(participantAudioLevel)
final participantAudioLevelProvider = AutoDisposeProviderFamily<double, String>.internal(
  participantAudioLevel,
  name: r'participantAudioLevelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$participantAudioLevelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ParticipantAudioLevelRef = AutoDisposeProviderRef<double>;
String _$currentSpeakersHash() => r'd7a9c2f5b8e1d4a7c9f2b5e8d1a4c7f9b2e5d8a1';

/// See also [currentSpeakers].
@ProviderFor(currentSpeakers)
final currentSpeakersProvider = AutoDisposeProvider<List<String>>.internal(
  currentSpeakers,
  name: r'currentSpeakersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSpeakersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentSpeakersRef = AutoDisposeProviderRef<List<String>>;
String _$participantVoiceQualityHash() => r'e8b1d4a7c9f2b5e8d1a4c7f9b2e5d8a1c4f7b9e2';

/// See also [participantVoiceQuality].
@ProviderFor(participantVoiceQuality)
final participantVoiceQualityProvider = AutoDisposeProviderFamily<VoiceQuality?, String>.internal(
  participantVoiceQuality,
  name: r'participantVoiceQualityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$participantVoiceQualityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ParticipantVoiceQualityRef = AutoDisposeProviderRef<VoiceQuality?>;
String _$voiceChatSettingsNotifierHash() => r'f9c2e5a8d1f4c7b9e2a5d8c1f4b7e9a2d5c8f1b4';

/// See also [VoiceChatSettingsNotifier].
@ProviderFor(VoiceChatSettingsNotifier)
final voiceChatSettingsNotifierProvider =
    AutoDisposeNotifierProvider<VoiceChatSettingsNotifier, VoiceChatSettings>.internal(
  VoiceChatSettingsNotifier.new,
  name: r'voiceChatSettingsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$voiceChatSettingsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VoiceChatSettingsNotifier = AutoDisposeNotifier<VoiceChatSettings>;
String _$voiceActivityNotifierHash() => r'a1d4f7b9e2a5d8c1f4b7e9a2d5c8f1b4e7a9c2f5';

/// See also [VoiceActivityNotifier].
@ProviderFor(VoiceActivityNotifier)
final voiceActivityNotifierProvider =
    AutoDisposeNotifierProvider<VoiceActivityNotifier, Map<String, VoiceActivity>>.internal(
  VoiceActivityNotifier.new,
  name: r'voiceActivityNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$voiceActivityNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VoiceActivityNotifier = AutoDisposeNotifier<Map<String, VoiceActivity>>;
String _$pushToTalkNotifierHash() => r'b2e5a8d1f4c7b9e2a5d8c1f4b7e9a2d5c8f1b4e7';

/// See also [PushToTalkNotifier].
@ProviderFor(PushToTalkNotifier)
final pushToTalkNotifierProvider =
    AutoDisposeNotifierProvider<PushToTalkNotifier, bool>.internal(
  PushToTalkNotifier.new,
  name: r'pushToTalkNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pushToTalkNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PushToTalkNotifier = AutoDisposeNotifier<bool>;
String _$voiceQualityMonitorHash() => r'c3f6b9e2a5d8c1f4b7e9a2d5c8f1b4e7a9c2f5d8';

/// See also [VoiceQualityMonitor].
@ProviderFor(VoiceQualityMonitor)
final voiceQualityMonitorProvider =
    AutoDisposeNotifierProvider<VoiceQualityMonitor, Map<String, VoiceQuality>>.internal(
  VoiceQualityMonitor.new,
  name: r'voiceQualityMonitorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$voiceQualityMonitorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VoiceQualityMonitor = AutoDisposeNotifier<Map<String, VoiceQuality>>;
String _$voiceChatRoomControllerHash() => r'd4a7c9f2b5e8d1a4c7f9b2e5d8a1c4f7b9e2a5d8';

/// See also [VoiceChatRoomController].
@ProviderFor(VoiceChatRoomController)
final voiceChatRoomControllerProvider =
    AutoDisposeNotifierProvider<VoiceChatRoomController, Map<String, dynamic>>.internal(
  VoiceChatRoomController.new,
  name: r'voiceChatRoomControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$voiceChatRoomControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VoiceChatRoomController = AutoDisposeNotifier<Map<String, dynamic>>;