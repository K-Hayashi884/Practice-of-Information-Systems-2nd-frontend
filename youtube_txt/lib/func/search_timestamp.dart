List<List?> searchTimestamp(String s) {
  // 文字列の中にタイムスタンプがあればその開始と末尾のスライスのインデックスを、なければ空のリスト を返す

  final List<List?> ans = [];
  var i = 1;
  while (i < s.length - 1) {
    if (s.substring(i, i + 1) == ":" &&
        s.substring(i - 1, i).contains(RegExp(r'^[0-9]')) &&
        s.substring(i + 1, i + 2).contains(RegExp(r'^[0-9]'))) {
      var start = i - 1;
      var end = i + 2;
      while (start > 0 &&
          s.substring(start - 1, start).contains(RegExp(r'^[0-9]'))) {
        start--;
      }
      while (end < s.length &&
          s.substring(end, end + 1).contains(RegExp(r'^[0-9]'))) {
        end++;
      }

      ans.add([start, end]);
      i = end + 1;
    } else {
      i++;
    }
  }

  return ans;
}
