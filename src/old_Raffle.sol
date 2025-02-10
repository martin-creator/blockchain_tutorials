// // Layout of the contract file:
// // version
// // imports
// // errors
// // interfaces, libraries, contract

// // Inside Contract:
// // Type declarations
// // State variables
// // Events
// // Modifiers
// // Functions

// // Layout of Functions:
// // constructor
// // receive function (if exists)
// // fallback function (if exists)
// // external
// // public
// // internal
// // private

// // view & pure functions

// // SPDX-License-Identifier: MIT

// pragma solidity ^0.8.18;

// import {VRFCoordinatorV2Interface} from "chainlink/src/v0.8/vrf/interfaces/VRFCoordinatorV2Interface.sol";

// import {VRFConsumerBaseV2} from "chainlink/src/v0.8/vrf/VRFConsumerBaseV2.sol";
// import {AutomationCompatibleInterface} from "chainlink/src/v0.8/automation/interfaces/AutomationCompatibleInterface.sol";

// /**
//  * @title A sample Raffle Contract
//  * @author Martin Joseph Lubowa
//  * @notice This contract is for creating a sample raffle
//  * @dev It implements Chainlink VRFv2.5 and Chainlink Automation
//  *
//  */
// contract Raffle is VRFConsumerBaseV2, AutomationCompatibleInterface {
//     /* Errors */
//     error Raffle__NotEnoughEthSent();
//     error Raffle__TransferFailed();
//     error Raffle__RaffleNotOpen();
//     error Raffle__UpkeepNotNeeded(uint256 currentBalance, uint256 numPlayers, uint256 raffleState);

//     /* Type Declarations */
//     enum RaffleState {
//         OPEN, // 0
//         CALCULATING // 1

//     }

//     /* State Variables */
//     uint256 private immutable i_entranceFee;
//     uint256 private immutable i_interval; // Interval for picking a winner
//     address payable[] private s_players; // Array of players
//     uint256 private s_lastTimeStamp; // Last time a raffle was picked
//     address payable private s_recentWinner;

//     VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
//     bytes32 private immutable i_gasLane;
//     uint64 private immutable i_subscriptionId;
//     uint16 private constant REQUEST_CONFIRMATIONS = 3;
//     uint32 private immutable i_callbackGasLimit;
//     RaffleState private s_raffleState;

//     uint32 private constant NUM_WORDS = 1;

//     /* Events */
//     event EnteredRaffle(address indexed player);
//     event PickedWinner(address winner);

//     /* Constructor */
//     constructor(
//         uint256 entranceFee,
//         uint256 interval,
//         address vrfCoordinator,
//         bytes32 gasLane,
//         uint64 subscriptionId,
//         uint32 callbackGasLimit
//     ) VRFConsumerBaseV2(vrfCoordinator) {
//         i_entranceFee = entranceFee;
//         i_interval = interval;
//         s_lastTimeStamp = block.timestamp;

//         i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinator);
//         i_gasLane = gasLane;
//         i_subscriptionId = subscriptionId;
//         i_callbackGasLimit = callbackGasLimit;
//         s_raffleState = RaffleState.OPEN;
//     }

//     /* Functions */
//     function enterRaffle() external payable {
//         // require(msg.value >= i_entranceFee, "Not enough ETH sent");
//         if (msg.value < i_entranceFee) revert Raffle__NotEnoughEthSent();
//         if (s_raffleState != RaffleState.OPEN) revert Raffle__RaffleNotOpen();
//         s_players.push(payable(msg.sender));
//         emit EnteredRaffle(msg.sender);
//     }

//     function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
//         uint256 indexOfWinner = randomWords[0] % s_players.length;
//         address payable winner = s_players[indexOfWinner];
//         s_recentWinner = winner;
//         s_players = new address payable[](0);
//         s_raffleState = RaffleState.OPEN;
//         s_lastTimeStamp = block.timestamp;
//         emit PickedWinner(winner);
//         (bool success,) = winner.call{value: address(this).balance}("");
//         if (!success) {
//             revert Raffle__TransferFailed();
//         }
//     }

//     /**
//      * @dev This is the function that the Chainlink Keeper nodes call
//      * they look for `upkeepNeeded` to return True.
//      * the following should be true for this to return true:
//      * 1. The time interval has passed between raffle runs.
//      * 2. The lottery is open.
//      * 3. The contract has ETH.
//      * 4. There are players registered.
//      * 5. Implicitly, your subscription is funded with LINK.
//      */
//     function checkUpkeep(bytes memory /* checkData */ )
//         public
//         view
//         returns (bool upkeepNeeded, bytes memory /* performData */ )
//     {
//         bool isOpen = RaffleState.OPEN == s_raffleState;
//         bool timePassed = ((block.timestamp - s_lastTimeStamp) >= i_interval);
//         bool hasPlayers = s_players.length > 0;
//         bool hasBalance = address(this).balance > 0;
//         upkeepNeeded = (timePassed && isOpen && hasBalance && hasPlayers);
//         return (upkeepNeeded, "0x0");
//     }

//     // 1. Get a random number
//     // 2. Use the random number to pick a player
//     // 3. Automatically called
//    function performUpkeep(bytes calldata /* performData */) external override {
//     (bool upkeepNeeded, ) = checkUpkeep("");
//     // require(upkeepNeeded, "Upkeep not needed");
//     if (!upkeepNeeded) {
//         revert Raffle__UpkeepNotNeeded(
//             address(this).balance,
//             s_players.length,
//             uint256(s_raffleState)
//         );
//     }
//     s_raffleState = RaffleState.CALCULATING;
//     VRFV2PlusClient.RandomWordsRequest memory request = VRFV2PlusClient.RandomWordsRequest({
//         keyHash: i_keyHash,
//         subId: i_subscriptionId,
//         requestConfirmations: REQUEST_CONFIRMATIONS,
//         callbackGasLimit: i_callbackGasLimit,
//         numWords: NUM_WORDS,
//         extraArgs: VRFV2PlusClient._argsToBytes(
//             // Set nativePayment to true to pay for VRF requests with Sepolia ETH instead of LINK
//             VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
//         )
//     });
//     uint256 requestId = s_vrfCoordinator.requestRandomWords(request);

//     emit RequestedRaffleWinner(requestId);

// }

//     /**
//      * Getter Function
//      */
//     function getRaffleState() public view returns (RaffleState) {
//         return s_raffleState;
//     }

//     function getNumWords() public pure returns (uint256) {
//         return NUM_WORDS;
//     }

//     function getRequestConfirmations() public pure returns (uint256) {
//         return REQUEST_CONFIRMATIONS;
//     }

//     function getRecentWinner() public view returns (address) {
//         return s_recentWinner;
//     }

//     function getPlayer(uint256 index) public view returns (address) {
//         return s_players[index];
//     }

//     function getLastTimeStamp() public view returns (uint256) {
//         return s_lastTimeStamp;
//     }

//     function getInterval() public view returns (uint256) {
//         return i_interval;
//     }

//     function getEntranceFee() public view returns (uint256) {
//         return i_entranceFee;
//     }

//     function getNumberOfPlayers() public view returns (uint256) {
//         return s_players.length;
//     }
// }
