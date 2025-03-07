///SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

//Contract
contract InsurePay {

    // Structure to store insurance and destination data
    struct Insurance {
        address company;       // Company Wallet
        address wallet;        // Destination Wallet
        uint256 amount;         // Amount required (in wei)
        string insuranceType;   // Type of insurence (ex: "life", "Auto")
    }

    // Mapping: Insurance ID => Insurance data
    mapping(uint256 => Insurance) public insurances;

    // Events to register actions
    event InsuranceAdded(uint256 id, address company, string insuranceType);
    event PaymentProcessed(uint256 id, address payer, uint256 amount);
    event InsuranceRemoved(uint256 indexed id);

    // Only the adminstrator can add/edit insurance
    address public owner;

    constructor (){
        owner = msg.sender;
    }


    modifier onlyOwner() {
        require(msg.sender == owner, "Only the adminstrator can run this");
        _;
    }

    //Add new insurance
    function addInsurance(
        uint256 _id,
        address _company,
        address _wallet,
        uint256 _amount,
        string memory _insuranceType
    ) external onlyOwner {
        insurances[_id] = Insurance(_company, _wallet, _amount, _insuranceType);
        emit InsuranceAdded(_id, _company, _insuranceType);
    }

    // Delete insurance
    function removeInsurance(uint256 _id) external onlyOwner {
        require(insurances[_id].wallet != address(0), "Insurance does not exist");
        delete insurances[_id];
        emit InsuranceRemoved(_id);
    }

    // Pay a specific insurance
    function payInsurance(uint256 _id) external payable {
        Insurance memory insurance = insurances[_id];
        require(msg.value == insurance.amount, "Incorrect amount");
        require(insurance.wallet != address(0), "Insurence does not registered");

    // Send the payment to the destination wallet
        (bool success, ) = insurance.wallet.call{value: msg.value}("");
        require(success, "Transfer failed");

        emit PaymentProcessed(_id, msg.sender, msg.value);
    }
}
