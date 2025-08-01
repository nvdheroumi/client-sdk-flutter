// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentRoomHash() => r'8a7d4c2b1f3e9a6d5c8b2e4f7a9c1d6e3b8f2a5c';

/// See also [currentRoom].
@ProviderFor(currentRoom)
final currentRoomProvider = AutoDisposeProvider<Room?>.internal(
  currentRoom,
  name: r'currentRoomProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentRoomHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentRoomRef = AutoDisposeProviderRef<Room?>;
String _$connectionStateHash() => r'9b8e5f2a4c7d1e6b3a9f4c8e2d5b7a1c6f9e3b8d';

/// See also [connectionState].
@ProviderFor(connectionState)
final connectionStateProvider = AutoDisposeProvider<RoomConnectionState>.internal(
  connectionState,
  name: r'connectionStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectionStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConnectionStateRef = AutoDisposeProviderRef<RoomConnectionState>;
String _$participantTracksHash() => r'a1c6f9e3b8d2e5a8c1f4b7e9d3a6c2f8b1e5d9a3';

/// See also [participantTracks].
@ProviderFor(participantTracks)
final participantTracksProvider = AutoDisposeProvider<List<ParticipantTrack>>.internal(
  participantTracks,
  name: r'participantTracksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$participantTracksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ParticipantTracksRef = AutoDisposeProviderRef<List<ParticipantTrack>>;
String _$isRecordingHash() => r'b2d5f8a1c4e7b9d2a5f8c1e4b7a9d2f5c8a1e4b7';

/// See also [isRecording].
@ProviderFor(isRecording)
final isRecordingProvider = AutoDisposeProvider<bool>.internal(
  isRecording,
  name: r'isRecordingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isRecordingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsRecordingRef = AutoDisposeProviderRef<bool>;
String _$roomNotifierHash() => r'c3e6a9b2d5f8c1e4a7b9d2f5c8a1e4b7a9d2f5c8';

/// See also [RoomNotifier].
@ProviderFor(RoomNotifier)
final roomNotifierProvider =
    AutoDisposeNotifierProvider<RoomNotifier, RoomState>.internal(
  RoomNotifier.new,
  name: r'roomNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RoomNotifier = AutoDisposeNotifier<RoomState>;