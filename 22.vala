class Coord {
    public int x;
    public int y;
    public int z;

    public Coord(int i, int j, int k) {
        x = i;
        y = j;
        z = k;
    }

    public bool isAbove(Coord other) {
        if (x == other.x && y == other.y) return z > other.z;
        return false;
    }

    public int canFall(Brick brick) {
        var minDist = int.MAX;
        if (!brick.isDesintegrated) {
            foreach (var c in brick.tiles) {
                if (isAbove(c)) {
                    var dist = z - c.z - 1;
                    if (dist < minDist) minDist = dist;
                }
            }
        }
        return minDist;
    }
}


class Brick {
    public int[] start;
    public int[] end;
    public Coord[] tiles;
    public bool isDesintegrated;
    public int id;

    public Brick(int idx, string brick) {
        string[] sp = brick.split("~");
        string[] startString = sp[0].split(",");
        start = new int[3];
        start[0] = int.parse(startString[0]);
        start[1] = int.parse(startString[1]);
        start[2] = int.parse(startString[2]);
        string[] endString = sp[1].split(",");
        end = new int[3];
        end[0] = int.parse(endString[0]);
        end[1] = int.parse(endString[1]);
        end[2] = int.parse(endString[2]);

        tiles = {};
        for (var i = start[0]; i <= end[0]; ++i) {
            for (var j = start[1]; j <= end[1]; ++j) {
                for (var k = start[2]; k <= end[2]; ++k) {
                    tiles += new Coord(i,j,k);
                }
            }
        }
        isDesintegrated = false;
        id = idx;
    }

    public string toString() {
        return "Brick " + id.to_string() + ": " + start[0].to_string() + "," + start[1].to_string() + "," + start[2].to_string() + "~" + end[0].to_string() + "," + end[1].to_string() + "," + end[2].to_string();
    }

    public bool fall(Brick[] bricks) {
        var maxFall = int.MAX;
        foreach(var tile in tiles) {
            foreach(var brick in bricks) {
                if (brick != this) {
                    var canFall = tile.canFall(brick);
                    if (canFall < maxFall) maxFall = canFall;
                }
            }
        }

        //  stdout.printf("Falling: %d\n", maxFall);

        if (maxFall != 0 && start[2] != 1) {
            if (maxFall == int.MAX) {
                maxFall = start[2] - 1;
            }
            start[2] -= maxFall;
            end[2] -= maxFall;
            foreach (var c in tiles) {
                c.z -= maxFall;
            }
            return true;
        }
        return false;
    }

    public bool willFall(Brick[] bricks) {
        var maxFall = int.MAX;
        foreach(var tile in tiles) {
            foreach(var brick in bricks) {
                if (brick != this) {
                    var canFall = tile.canFall(brick);
                    if (canFall < maxFall) maxFall = canFall;
                }
            }
        }
        if (maxFall != 0 && start[2] != 1) {
            return true;
        }
        return false;
    }
}

void main(string[] args) {
    var line = stdin.read_line();
    Brick[] bricks = {};
    var id = 0;
    while (line != "DONE") {
        var b = new Brick(id, line);
        bricks += b;
        ++id;
        line = stdin.read_line();
    }

    var falling = true;
    while (falling) {
        falling = false;
        foreach (var b in bricks) {
            stdout.printf("Brick falling from %s to ", b.toString());
            falling = b.fall(bricks) || falling;
            stdout.printf("%s\n", b.toString());
        }
    }
    foreach (var b in bricks) stdout.printf("%s\n", b.toString());

    var sum = 0;

    foreach (var b in bricks) {
        stdout.printf("Checking %s\n", b.toString());
        b.isDesintegrated = true;
        falling = false;
        foreach (var b2 in bricks) {
            if (b2 != b) {
                falling = b2.willFall(bricks) || falling;
            }
        }
        b.isDesintegrated = false;
        if (!falling) ++sum;
    }

    stdout.printf("Part one solution: %d\n", sum);

    

}