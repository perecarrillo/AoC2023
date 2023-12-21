import 'dart:io';

List<String> processLine(String line) {
    return line.split("");
}

bool inside(List<List<String>> map, x, y) {
    if (x < 0 || x >= map.length || y < 0 ||y >= map[0].length) return false;
    return true;
}

void step(List<List<String>> map) {
    for (var i = 0; i < map.length; ++i) {
        for (var j = 0; j < map[i].length; ++j) {
            if (inside(map, i - 1, j) && map[i-1][j] == "O") map[i][j] = "O";
            if (inside(map, i + 1, j) && map[i+1][j] == "O") map[i][j] = "O";
            if (inside(map, i, j - 1) && map[i][j-1] == "O") map[i][j] = "O";
            if (inside(map, i, j + 1) && map[i][j+1] == "O") map[i][j] = "O";
        }
    }
}

void main(){
    
    final map = File('/uploads/21.in').readAsLinesSync().map(processLine).toList();
    
    var x; 
    var y;
    
    for (final (k, v) in map.indexed) {
        var idx = v.indexOf('S');
        if (idx != -1) {
            x = idx;
            y = k;
            v[idx] = 'O';
        }
    }
    
    map.forEach((l) => print(l.join()));
    
    for (var i = 0; i < 64; ++i) {
        step(map);
    }
    
    var sum = map.reduce((sum, elem) => sum + elem.reduce((lineSum, ch) => lineSum + ch == 'O' ? 1 : 0));
    print("Part one result: #sum");
}