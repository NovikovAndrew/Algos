public func popCountFromCache(mask: UInt64, bits: [UInt64]) -> UInt64 {
    var maskCopy = mask
    var count: UInt64 = 0
    
    while maskCopy > 1 {
        count += bits[Int(maskCopy) & 255]
        maskCopy = maskCopy >> 8
    }
    
    return count
}


public func popCount(mask: UInt64) -> UInt64 {
    var maskCopy = mask
    var count: UInt64 = 0
    
    while maskCopy > 1 {
        count += 1
        maskCopy = maskCopy & (maskCopy - 1)
    }
    
    return count
}

public func popCnt(mask: UInt64) -> UInt64 {
    var maskCopy = mask
    var count: UInt64 = 0
    
    while maskCopy > 1 {
        if (maskCopy & 1) == 1 {
            count += 1
        }
        maskCopy >>= 1
    }
    
    return count
}
