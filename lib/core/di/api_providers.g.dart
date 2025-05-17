// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'237e4aa4d9267e83c6c6e53bd7c8182ecdf84da5';

/// See also [dio].
@ProviderFor(dio)
final dioProvider = Provider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRef = ProviderRef<Dio>;
String _$chatGPTDioHash() => r'0d675edec833f88d081891b1a2da2980564b627d';

/// See also [chatGPTDio].
@ProviderFor(chatGPTDio)
final chatGPTDioProvider = AutoDisposeProvider<Dio>.internal(
  chatGPTDio,
  name: r'chatGPTDioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatGPTDioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ChatGPTDioRef = AutoDisposeProviderRef<Dio>;
String _$wordApiServiceHash() => r'eac23306c3fc0356b2b3de21f499bb2d31b9d708';

/// See also [wordApiService].
@ProviderFor(wordApiService)
final wordApiServiceProvider = AutoDisposeProvider<WordApiService>.internal(
  wordApiService,
  name: r'wordApiServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wordApiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WordApiServiceRef = AutoDisposeProviderRef<WordApiService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
