import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_provider.g.dart';

@riverpod
SupabaseClient supabase(SupabaseRef ref) {
  try {
    final client = Supabase.instance.client;
    if (client == null) {
      throw Exception('Supabase client is not initialized');
    }
    return client;
  } catch (e) {
    print('Error getting Supabase client: $e');
    throw Exception('Failed to get Supabase client: $e');
  }
}
