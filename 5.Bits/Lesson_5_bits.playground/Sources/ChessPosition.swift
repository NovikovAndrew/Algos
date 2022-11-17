struct ChessPosition {
    // white and black
    var pawns: UInt64 = 1
    var rocks: UInt64 = 9295429630892703873
    var bishop: UInt64 = 1
    var knight: UInt64 = 1
    var queens: UInt64 = 1
    var kings: UInt64 = 1
    
    
    let blackMask: UInt64 = 65535
    let whiteMask: UInt64 = 65535
    
    // rocks & whiteMask
    // king 8 or 3 or 5
    // king in 27 position = 1 << 27
    
    // left number >> 1
    // right number << 1
    // left bottom number >> 9
    // rigt bottom number >> 7
    // left top number << 7
    // right top number << 9
    // bottom number >> 8
    // top nuttom << 8
}

/*
 ab a&b a|b !a XOR
 00 0   0   1  0
 01 0   1   1  1
 10 0   1   0  1
 11 §   1   0  0
 
 1100 | 1010
 1100 & 1110
 1100 XOR 1010
 
 1100 = even -> 0 1100 / 2 = 550 -> even 00 -> 550 / 2 275 -> odd 100 ... -> 10001001100 = 2^10 + 2^6 + 2^3 + 2^2 = 1100
 1010 = 01111110010
 
 10001001100 | 01111110010 = 11111111110
 10001001100 & 01111110010 = 00001000000
 10001001100 XOR 011111100 10 = 11110111110
 */
