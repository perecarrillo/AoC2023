fn main() {
    let mut line = String::new();
    std::io::stdin().read_line(&mut line).unwrap();
    // const MAP_SIZE : usize = 1000; // Part One
    // let mut map = [[0; MAP_SIZE]; MAP_SIZE]; // Part One
    // let mut x : usize = 500; // Part One
    // let mut y : usize = 500; // Part One
    let mut area = 0;
    
    let mut x : i128 = 1000000000; // Part Two
    let mut y : i128 = 1000000000;
    
    while line != "DONE\n" {
        // println!("{}", line);
        
        let mut it = line.split_whitespace();
        it.next(); // Part Two
        it.next();
        let string = it.next().unwrap().trim();
        let dir = string.chars().nth(7).unwrap();
        let s : String = string.chars().skip(2).take(5).collect();
        let len : i128 = i128::from_str_radix(s.as_str(), 16).unwrap();
        
        if dir == '0' {
            area += y*len;
            y = y + len;
        }
        else if dir == '1' {
            x = x + len;
        }
        else if dir == '2' {
            area -= y*len;
            y = y - len;
        }
        else if dir == '3' {
            x = x - len;
        }
        
        println!("New Area: {}", area);
        
        // let dir = it.next().unwrap(); // Part One
        // let len : i32 = it.next().unwrap().parse::<i32>().unwrap(); // Part One
        println!("{}, {}", dir, len);
        /*for _ in 0..len { // Part One
            map[x][y] = 1;
            if dir == "R" {
                y += 1;
            }
            else if dir == "L" {
                y -= 1;
            }
            else if dir == "U" {
                x -= 1;
            }
            else {
                x += 1;
            }
        }*/
        
        
        // println!("{}, {}", x, y);
        line = String::new();
        std::io::stdin().read_line(&mut line).unwrap();
    }
    /*println!("{}, {}", x, y); // Part One
    // println!("{:?}", map);
    
    for i in 0..MAP_SIZE {
        map[i][0] = 2;
        map[i][MAP_SIZE-1] = 2;
        map[0][i] = 2;
        map[MAP_SIZE-1][i] = 2;
        
    }
    
    for _ in 0..1000 {
        for i in 1..MAP_SIZE - 1 {
            for j in 1..MAP_SIZE - 1 {
                if map[i][j] == 0 && (map[i-1][j] == 2 || map[i+1][j] == 2 || map[i][j-1] == 2 || map[i][j+1] == 2) {
                    map[i][j] = 2;
                }
            }
        }
    }
    
    
    for i in 0..MAP_SIZE {
        for j in 0..MAP_SIZE {
            if map[i][j] == 0 || map[i][j] == 1 {
                sum += 1;
            }
        }
    }*/
    
    println!("Total area: {}", area);
    
}