void main() {
  List<String> words = ['GOOD', 'NOON'];

  for (String word in words) {
    if (isPalindrome(word)) {
      print('$word: Palindrome');
    } else {
      print('$word: Not a Palindrome');
    }
  }
}

bool isPalindrome(String word) {
  String reversed = word.split('').reversed.join('');
  return word == reversed;
}
