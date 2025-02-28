import 'package:flutter/material.dart';
import '../Model/Repository/HomePageRepo.dart';

class HomePageViewModel extends ChangeNotifier {
  final HomePageRepository _repository = HomePageRepository();
  String _quote = '';
  String _author = '';
  bool _isLoading = false;
  String get quote => _quote;
  String get author => _author;
  bool get isLoading => _isLoading;

  Future<void> getRandomQuote() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await _repository.fetchRandomQuote();
      _quote = data['content'];
      _author = data['author'];
    } catch (e) {
      _quote = 'Failed to fetch quote';
      _author = '';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}