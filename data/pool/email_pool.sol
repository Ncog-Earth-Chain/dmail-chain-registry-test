// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface OtherContractInterface {
    function sendEmailRequest(string calldata username, string calldata subject, string calldata encryptedData, address walletAddress, string calldata dateValue, string calldata senderName) external;
}

contract EmailRegistry {
    mapping(string => string[]) private emailsByDomain;
    mapping(string => string[]) private emailsForSending;

    function saveEmailsBasedOnDomain(string memory domain, string memory email) public {
        emailsByDomain[domain].push(email);
    }

    function getEmailsByDomain(string memory domain) public view returns (string[] memory) {
        return emailsByDomain[domain];
    }
    
    function deleteEmailsBasedOnDomain(string memory domain) public {
        string[] storage emails = emailsByDomain[domain];
        for (uint i = 0; i < emails.length; i++) {
            delete emails[i];
        }
        delete emailsByDomain[domain];
    }

    function sendEmailsBasedOnDomain(string memory domain, string memory email) public {
        emailsForSending[domain].push(email);
    }

    function getSendEmailsByDomain(string memory domain) public view  returns (string[] memory) {
        return emailsForSending[domain];
    }

    function deleteSendEmailsBasedOnDomain(string memory domain) public {
        string[] storage emails = emailsForSending[domain];
        for (uint i = 0; i < emails.length; i++) {
            delete emails[i];
        }
        delete emailsForSending[domain];
    }

    function callSendEmailRequest(string calldata username, string calldata subject, string calldata encryptedData, address walletAddress, string calldata dateValue, string calldata senderName , address otherContractAddress) public {
        OtherContractInterface otherContract = OtherContractInterface(otherContractAddress);
        otherContract.sendEmailRequest(username, subject, encryptedData, walletAddress, dateValue, senderName);
    }
}
