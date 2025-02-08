// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {
    // uint256 favNumber = 0;
    // bool greatCourse = false;
    FundMe fundMe;

    function setUp() external {
        // favNumber = 1337;
        // greatCourse = true;
        // console.log("This will get printed first!");
        fundMe = new FundMe(); // Deploy a new FundMe contract
    }

    function testMinimumDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        console.log(fundMe.i_owner());
        console.log(msg.sender);
        // assertEq(fundMe.i_owner(), msg.sender);
        assertEq(fundMe.i_owner(), address(this));
    }

    // function testDemo() public view {
    //     assertEq(favNumber, 1337);
    //     assertEq(greatCourse, true);
    //     console.log("This will get printed second!");
    //     console.log("Updraft is changing lives!");
    //     console.log(
    //         "You can print multiple things, for example this is a uint256, followed by a bool:", favNumber, greatCourse
    //     );
    // }
}
