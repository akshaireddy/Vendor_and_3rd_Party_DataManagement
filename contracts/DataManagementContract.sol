// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract DataManagementContract is Initializable, OwnableUpgradeable {
    struct Data {
        string dataHash;
        address vendor;
        bool authorized;
    }

    mapping(uint256 => Data) public dataRecords;
    uint256 public dataCounter;

    modifier onlyAuthorized(uint256 _dataId) {
        require(dataRecords[_dataId].authorized, "Access not authorized");
        _;
    }

    function initialize() public initializer {
        __Ownable_init();
        dataCounter = 0;
    }

    function addData(string memory _dataHash) public onlyOwner {
        dataCounter++;
        dataRecords[dataCounter] = Data(_dataHash, address(0), false);
    }

    function authorizeVendor(uint256 _dataId, address _vendor) public onlyOwner {
        require(dataRecords[_dataId].vendor == address(0), "Vendor already authorized");
        dataRecords[_dataId].vendor = _vendor;
        dataRecords[_dataId].authorized = true;
    }

    function revokeAuthorization(uint256 _dataId) public onlyOwner {
        dataRecords[_dataId].authorized = false;
    }

    function getData(uint256 _dataId) public view onlyAuthorized(_dataId) returns (string memory) {
        return dataRecords[_dataId].dataHash;
    }
}
