// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract HostRegistryContract {

    struct UserData {
        address contractAddress;
        string userData;
    }
    
    mapping(string => UserData) public users;

    function ping() external pure returns (string memory) {
        return "yes";
    }

    // Function to set the address of the contract and string variable based on username
    function registerChain( string memory username, address _contractAddress,  string memory _userData ) public {
        users[username] = UserData(_contractAddress, _userData);
    }

    // Function to get the address of the contract and string variable based on username
    function getChainDetails(string memory username) public view returns (address, string memory) {
        UserData memory userData = users[username];
        return (userData.contractAddress, userData.userData);
    }

    // Function to update the address of the contract and string variable based on username
    function updateChain(string memory username, address _contractAddress, string memory _userData) public {
        require(users[username].contractAddress != address(0), "User does not exist");
        users[username] = UserData(_contractAddress, _userData);
    }

    // Function to delete user data based on username
    function deleteChain(string memory username) public {
        require(users[username].contractAddress != address(0), "User does not exist");
        delete users[username];
    }
}
