pragma solidity ^0.4.24;

import "ds-test/test.sol";

import "./ReadALot.sol";

contract ReadALotTest is DSTest {
    ReadALot lot;

    function setUp() public {
        lot = new ReadALot();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
