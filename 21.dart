import 'dart:io';

List<String> processLine(String line) {
    return line.split("");
}

bool inside(List<List<String>> map, x, y) {
    if (x < 0 || x >= map.length || y < 0 ||y >= map[0].length) return false;
    return true;
}

List<List<String>> step(List<List<String>> map) {
    var result = map.map((element) => List<String>.from(element)).toList();
    for (var i = 0; i < map.length; ++i) {
        for (var j = 0; j < map[i].length; ++j) {
            if (result[i][j] == 'O') result[i][j] = '.';
            if (result[i][j] != '.') continue;
            if (inside(map, i - 1, j) && map[i-1][j] == "O") result[i][j] = "O";
            if (inside(map, i + 1, j) && map[i+1][j] == "O") result[i][j] = "O";
            if (inside(map, i, j - 1) && map[i][j-1] == "O") result[i][j] = "O";
            if (inside(map, i, j + 1) && map[i][j+1] == "O") result[i][j] = "O";
        }
    }
    return result;
}

void main(){
    
    var map = File('./21.realin').readAsLinesSync().map(processLine).toList();
    
    var x; 
    var y;
    
    for (final (k, v) in map.indexed) {
        var idx = v.indexOf('S');
        if (idx != -1) {
            x = idx;
            y = k;
            v[idx] = '.';
        }
    }
    
    // map.forEach((l) => print(l.join()));
    
    /*x = 130 + 65;
    y = 130 + 65;



    for (var k = 0; k < 1; ++k) {
        var rows = map.length;
        var cols = map[0].length;
        for (var i = 0; i < rows; ++i) {
            map[i] = [...map[i], ...map[i], ...map[i]];
            map.add([...map[i]]);
        }
        for (var i = 0; i < rows; ++i) {
            map.add([...map[i]]);
        }
    }*/
    
    x = 65;
    y = 65;

    map[x][y] = 'O';

    for (var i = 0; i < 65; ++i) {
        if (i%10000 == 0) print(i);
        map = step(map);
    }
    
    map.forEach((l) => print(l.join()));
    
    var sum = map.fold<int>(0, (sum, elem) => sum + elem.fold<int>(0, (lineSum, ch) => lineSum + (ch == 'O' ? 1 : 0)));
    print('Part one result: $sum');

    // var full = 7320;
    var full = 7335;
    var allFromMid = 5506 + 5522 + 5518 + 5534;
    var n = 1; //(26501365 - 65) / 131 - 1; // 202300
    var tl = 971;
    var tr = 959;
    var bl = 975;
    var br = 959;

    var sumaFinal = full + allFromMid + 4*(n*(n-1)/2) * full + (n-1)*(6427 + 6427 + 6415 + 6411) + n*(tl + tr + bl + br);
    print('Part two result: $sumaFinal');
}
