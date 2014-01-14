var UTIL = {
    IntToHex : function(number) {
        return number.toString(16);
    },
    
    HexToInt : function(hexstring) {
        return parseInt(hexstring, 16);
    },
    
    RandomBits : function(bitCount) {
        // floor the decimal to get an int
        // grab a random
        // add a 1 to round down from
        // 2^bits caps our numberline
        return Math.floor(Math.random()*(1 + Math.pow(2, bitCount)));
    },
    
    RandomBit : function() {
        return Math.floor(Math.random()*2);
    },
}
