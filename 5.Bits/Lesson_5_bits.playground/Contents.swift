import CoreFoundation
import Darwin
import Security

example(title: "---Left & Right shift---") {
    let a = 10
    print(a << 1)
    print(a >> 1)
}

class BitArithmetic {
    // MARK: - Nested types
    
    enum Position {
        static let notAColom: UInt64 = 0xfefefefefefefefe
        static let notABColom: UInt64 = 0xfcfcfcfcfcfcfcfc
        static let notHColom: UInt64 = 0x7f7f7f7f7f7f7f7f
        static let notHGColom: UInt64 = 0x3f3f3f3f3f3f3f3f
        
        static let oneHorizontal: UInt64 = 255
        static let aVertical: UInt64 = 72340172838076673
    }
    
    // MARK: - Private properties
    
    var bits = [UInt64]()
    
    // MARK: - Object livecycle
    
     init() {
        for bit in 0..<256 {
            bits.append(popCnt(mask: UInt64(bit)))
        }
    }
    
    // MARK: - Instance methods
    
    func getKingMoves(kingPosiiton: UInt64) -> UInt64 {
        let kingMask: UInt64 = 1 << kingPosiiton
        let kingCanToMoveA: UInt64 = kingMask & Position.notAColom
        let kingCanToMoveH: UInt64 = kingMask & Position.notHColom
        let mask: UInt64 = (kingCanToMoveA << 7) | (kingMask << 8) | (kingCanToMoveH << 9) |
                           (kingCanToMoveA >> 1)                   | (kingCanToMoveH << 1) |
                           (kingCanToMoveA >> 9) | (kingMask >> 8) | (kingCanToMoveH >> 7)
        return mask
    }
    
    func getKnightMoves(knightPosition: UInt64) -> UInt64 {
        let knightMask: UInt64 = 1 << knightPosition
        let knightNotAColom: UInt64 = Position.notAColom
        let knightNotABColom: UInt64 = Position.notABColom
        let knightNotHColom: UInt64 = Position.notHColom
        let knightNotHGColom: UInt64 = Position.notHGColom
        
        let mask: UInt64 = knightNotHGColom & (knightMask << 6 |  knightMask >> 10) | // horizontal left
                           knightNotHColom  & (knightMask << 15 | knightMask >> 17) | // vertical left
                           knightNotAColom  & (knightMask << 17 | knightMask >> 15) | // vertical right
                           knightNotABColom & (knightMask << 10 | knightMask >>  6)   // horizontal right
        
        return mask
    }
    
    func getRookPosition(rookPosition: UInt64) -> UInt64 {
        let rookMask: UInt64 = 1 << rookPosition
        let xDir = UInt64(rookPosition / 8) * 8 // coordinate by y need to shift
        let yDir = UInt64(rookPosition % 8)     // coordinate by x need to shift
        let positionX = rookMask ^ (Position.oneHorizontal << xDir)
        let positionY = rookMask ^ (Position.aVertical << yDir)
            
        return positionX ^ positionY
    }
}

let bitArithmetic = BitArithmetic()

example(title: "---king---") {
    print(bitArithmetic.getKingMoves(kingPosiiton: 31)) // 31 -> 825720045568
    print(popCnt(mask: bitArithmetic.getKingMoves(kingPosiiton: 24)))
}

example(title: "---knight---") {
    print(bitArithmetic.getKnightMoves(knightPosition: 41)) // 41 -> 362539804446949376
    print(bitArithmetic.getKnightMoves(knightPosition: 32)) // 32 -> 567348067172352
    print(bitArithmetic.getKnightMoves(knightPosition: 39)) // 41 -> 72620552598061056
    print(bitArithmetic.getKnightMoves(knightPosition: 38)) // 41 -> 362539804446949376
    
    print(popCnt(mask: bitArithmetic.getKnightMoves(knightPosition: 41)))
    print(popCnt(mask: bitArithmetic.getKnightMoves(knightPosition: 32)))
    print(popCnt(mask: bitArithmetic.getKnightMoves(knightPosition: 39)))
    print(popCnt(mask: bitArithmetic.getKnightMoves(knightPosition: 38)))
}

example(title: "---rook---") {
    print(bitArithmetic.getRookPosition(rookPosition: 41)) // 40 -> 144956323094725122
    print(bitArithmetic.getRookPosition(rookPosition: 32)) // 32 -> 72341259464802561
    print(bitArithmetic.getRookPosition(rookPosition: 39)) // 39 -> 9259542118978846848
    print(bitArithmetic.getRookPosition(rookPosition: 0))  // 0 -> 72340172838076926
    print(bitArithmetic.getRookPosition(rookPosition: 61)) // 61 -> 16077885992062689312
    
    print(popCnt(mask: bitArithmetic.getRookPosition(rookPosition: 41)))
    print(popCnt(mask: bitArithmetic.getRookPosition(rookPosition: 32)))
    print(popCnt(mask: bitArithmetic.getRookPosition(rookPosition: 39)))
    print(popCnt(mask: bitArithmetic.getRookPosition(rookPosition: 0)))
    print(popCnt(mask: bitArithmetic.getRookPosition(rookPosition: 61)))

    //print(popCountFromCache(mask: bitArithmetic.getRookPosition(rookPosition: 41), bits: bitArithmetic.bits))
    //print(popCountFromCache(mask: bitArithmetic.getRookPosition(rookPosition: 32), bits: bitArithmetic.bits))
    //print(popCountFromCache(mask: bitArithmetic.getRookPosition(rookPosition: 39), bits: bitArithmetic.bits))
    //print(popCountFromCache(mask: bitArithmetic.getRookPosition(rookPosition: 0), bits: bitArithmetic.bits))
    //print(popCountFromCache(mask: bitArithmetic.getRookPosition(rookPosition: 61), bits: bitArithmetic.bits))
}

