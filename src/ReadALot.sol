pragma solidity 0.4.24;

contract ReadALot {
    function aggregate(bytes data) public view returns (bytes) {
        uint256 malloc;
        assembly { malloc := mul(mload(add(data, 0x20)), 0x20) }
        bytes memory tempBytes = new bytes(malloc);
        assembly {
            let ptr := mload(0x40) 
            let cur := 0x40
            let inc := 1
            let len := mload(data)

            for { } lt(cur, len) { } {
                let _target     := mload(add(data, cur))
                let _retLen     := mul(mload(add(data, add(cur, 0x20))), 0x20)
                let _dataLength := mload(add(data, add(cur, 0x60)))
                let _data       := add(data, add(cur, 0x80))
                if eq(call(gas, _target, 0, _data, _dataLength, ptr, _retLen), 0) 
                    { revert(0, 0) }
                let _retVal := mload(ptr)
                mstore(add(tempBytes, mul(inc, 0x20)), _retVal)
                inc := add(inc, mload(add(data, add(cur, 0x20))))
                cur := add(cur, add(0x80, mul(div(add(_dataLength, 0x1f), 0x20), 0x20)))
            }
        }
        return tempBytes;
    }
}
