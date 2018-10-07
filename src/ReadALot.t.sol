pragma solidity ^0.4.24;

import "ds-test/test.sol";

import "./ReadALot.sol";

contract Store {
    uint256 internal val;
    function set(uint256 _val) public { val = _val; }
    function get() public view returns (uint256, uint256) { return (val, val); }
    function getAdd(uint256 _val) public view returns (uint256) { return val + _val; }
}

contract MultiCallTest is DSTest {
    using BytesLib for bytes;

    MultiCall multicall;
    Store        storeA;
    Store        storeB;

    function setUp() public {
        multicall = new MultiCall();
        storeA    = new Store();
        storeB    = new Store();
    }

    function test_store_basic_sanity() public {
        assertEq(storeA.get(), 0);
        storeA.set(100);
        assertEq(storeA.get(), 100);
        storeA.set(0);
        assertEq(storeA.get(), 0);
    }

    // event A(bytes t);
    // function test_single_call_no_args() public {
    //     storeA.set(123);
    //     bytes memory a = abi.encode(storeA, abi.encodeWithSignature("balanceOf(address)", 0x40502eaa3fcfd60ef97162a8b2246995e42dbeac));
    //     emit A(a);
    //     assertTrue(false);
    // }
}
