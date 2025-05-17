abstract class MakeVocabularyRepository {
  Future<bool> hasDefaultBookshelf();
  Future<bool> createDefaultBookshelf();
  Future<bool> createWordbook(String name, String description, String color, String languageFrom, String languageTo);
  Future<Map<String, dynamic>> searchWord(String word);
}
