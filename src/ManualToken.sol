// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ManualToken {

    mapping(address => uint256) private s_balances;

    function name() public pure returns(string memory) {
        return "Manual Token";
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether; // 100000000000000000000
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function balanceOf(address _owner) public pure returns (uint256) {
   return s_balances[_owner];
    }

   function transfer(address _to, uint256 _amount) public {
    uint256 previousBalance = balanceOf(msg.sender) + balanceOf(_to);
    s_balance[msg.sender] -= _amount;
    s_balance[_to] += _amount;

    require(s_balance(msg.sender) + s_balance(_to) == previousBalance);
}

}
