pragma solidity ^0.8.0;

contract InteractiveWebAppIntegrator {
    struct App {
        string name;
        string description;
        address creator;
        uint256 creationTime;
        uint256 lastUpdated;
        bool isActive;
    }

    struct Integration {
        string appId;
        string componentName;
        string componentType;
        string configuration;
        uint256 integrationTime;
    }

    mapping(string => App) public apps;
    mapping(string => Integration[]) public integrations;

    event AppCreated(string appId, string appName);
    event IntegrationAdded(string appId, string componentName);

    function createApp(string memory _name, string memory _description) public {
        App storage newApp = apps[_name];
        newApp.name = _name;
        newApp.description = _description;
        newApp.creator = msg.sender;
        newApp.creationTime = block.timestamp;
        newApp.lastUpdated = block.timestamp;
        newApp.isActive = true;
        emit AppCreated(_name, _name);
    }

    function addIntegration(string memory _appId, string memory _componentName, string memory _componentType, string memory _configuration) public {
        Integration[] storage appIntegrations = integrations[_appId];
        Integration memory newIntegration;
        newIntegration.appId = _appId;
        newIntegration.componentName = _componentName;
        newIntegration.componentType = _componentType;
        newIntegration.configuration = _configuration;
        newIntegration.integrationTime = block.timestamp;
        appIntegrations.push(newIntegration);
        emit IntegrationAdded(_appId, _componentName);
    }

    function getApp(string memory _appId) public view returns (App memory) {
        return apps[_appId];
    }

    function getIntegrations(string memory _appId) public view returns (Integration[] memory) {
        return integrations[_appId];
    }
}