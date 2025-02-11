// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";
//import {VM} from "forge-std/VM.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    address public user1 = address(0x123);
    address public user2 = address(0x456);

    uint256 public constant STARTING_BALANCE = 100 ether;

    //VM public vm;

    /* events */
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
        vm.deal(user1, 1 ether); // Giving some initial balance to user1 for transactions
        vm.deal(user2, 1 ether); // Giving some initial balance to user2 for transactions
    }


    function testBobBalance() public view {
    assertEq(STARTING_BALANCE, ourToken.balanceOf(bob));
}

function testAllowancesWork() public {
    uint256 initialAllowance = 1000;

    // Bob approves Alice to spend 1000 tokens.
    vm.prank(bob);
    ourToken.approve(alice, initialAllowance);

    uint256 transferAmount = 500;

    vm.prank(alice);
    ourToken.transferFrom(bob, alice, transferAmount);

    assertEq(ourToken.balanceOf(alice), transferAmount);
    assertEq(ourToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
}

function testAllowance() public {
        uint256 amount = 1000 * 10 ** 18; // Example amount
        vm.prank(msg.sender);
        ourToken.approve(user1, amount);

        assertEq(ourToken.allowance(msg.sender, user1), amount);
    }

    function testTransfer() public {
        uint256 amount = 1000 * 10 ** 18; // Example amount
        vm.prank(msg.sender);
        ourToken.transfer(user1, amount);

        assertEq(ourToken.balanceOf(user1), amount);
        assertEq(ourToken.balanceOf(msg.sender), deployer.INITIAL_SUPPLY() - amount);
    }

    function testTransferFrom() public {
        uint256 amount = 500 * 10 ** 18; // Example amount
        vm.prank(msg.sender);
        ourToken.approve(user1, amount);

        vm.prank(user1);
        ourToken.transferFrom(msg.sender, user2, amount);

        assertEq(ourToken.balanceOf(user2), amount);
        assertEq(ourToken.allowance(msg.sender, user1), 0);
    }

    function testFailTransferExceedsBalance() public {
        uint256 amount = deployer.INITIAL_SUPPLY() + 1;
        vm.prank(msg.sender);
        ourToken.transfer(user1, amount); // This should fail
    }

    function testFailApproveExceedsBalance() public {
        uint256 amount = deployer.INITIAL_SUPPLY() + 1;
        vm.prank(msg.sender);
        ourToken.approve(user1, amount); // This should fail
    }

    function testTransferEvent() public {
        uint256 amount = 1000 * 10 ** 18; // Example amount
        vm.prank(msg.sender);
        vm.expectEmit(true, true, false, true);
        emit Transfer(msg.sender, user1, amount);
        ourToken.transfer(user1, amount);
    }

    function testApprovalEvent() public {
        uint256 amount = 1000 * 10 ** 18; // Example amount
        vm.prank(msg.sender);
        vm.expectEmit(true, true, false, true);
        emit Approval(msg.sender, user1, amount);
        ourToken.approve(user1, amount);
    }

}